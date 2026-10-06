import 'dart:convert';

import 'package:Bloomee/core/constants/setting_keys.dart';
import 'package:Bloomee/services/db/dao/settings_dao.dart';

enum NotificationPlayerControlAction {
  playPause,
  previous,
  next,
  addToLiked,
  addToPlaylist,
  repeat,
  shuffle,
  restartFromBeginning,
}

class NotificationPlayerControlPreference {
  final NotificationPlayerControlAction action;
  final bool enabled;

  const NotificationPlayerControlPreference({
    required this.action,
    required this.enabled,
  });

  NotificationPlayerControlPreference copyWith({
    NotificationPlayerControlAction? action,
    bool? enabled,
  }) {
    return NotificationPlayerControlPreference(
      action: action ?? this.action,
      enabled: enabled ?? this.enabled,
    );
  }

  Map<String, dynamic> toJson() => {
        'action': action.name,
        'enabled': enabled,
      };
}

class NotificationPlayerControlsConfig {
  static const List<NotificationPlayerControlAction> defaultOrder = [
    NotificationPlayerControlAction.playPause,
    NotificationPlayerControlAction.previous,
    NotificationPlayerControlAction.next,
    NotificationPlayerControlAction.addToLiked,
    NotificationPlayerControlAction.addToPlaylist,
    NotificationPlayerControlAction.repeat,
    NotificationPlayerControlAction.shuffle,
    NotificationPlayerControlAction.restartFromBeginning,
  ];

  static List<NotificationPlayerControlPreference> defaultPreferences() {
    return defaultOrder
        .map((action) =>
            NotificationPlayerControlPreference(action: action, enabled: true))
        .toList(growable: false);
  }

  static Future<List<NotificationPlayerControlPreference>> load(
      SettingsDAO settingsDao) async {
    final raw = await settingsDao.getSettingStr(
      SettingKeys.notificationPlayerControls,
    );
    return decode(raw);
  }

  static Future<void> save(
    SettingsDAO settingsDao,
    List<NotificationPlayerControlPreference> preferences,
  ) async {
    final payload = jsonEncode(preferences.map((e) => e.toJson()).toList());
    await settingsDao.putSettingStr(SettingKeys.notificationPlayerControls, payload);
  }

  static List<NotificationPlayerControlPreference> decode(String? raw) {
    final fallback = defaultPreferences();
    if (raw == null || raw.trim().isEmpty) return fallback;
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) return fallback;

      final byAction = <NotificationPlayerControlAction, bool>{};
      final ordered = <NotificationPlayerControlAction>[];

      for (final item in decoded) {
        if (item is! Map) continue;
        final actionName = item['action']?.toString();
        if (actionName == null) continue;

        NotificationPlayerControlAction? parsed;
        for (final action in NotificationPlayerControlAction.values) {
          if (action.name == actionName) {
            parsed = action;
            break;
          }
        }
        if (parsed == null || byAction.containsKey(parsed)) continue;
        final enabled = item['enabled'];
        byAction[parsed] = enabled is bool ? enabled : true;
        ordered.add(parsed);
      }

      for (final action in defaultOrder) {
        byAction.putIfAbsent(action, () => true);
        if (!ordered.contains(action)) ordered.add(action);
      }

      return ordered
          .map(
            (action) => NotificationPlayerControlPreference(
              action: action,
              enabled: byAction[action] ?? true,
            ),
          )
          .toList(growable: false);
    } catch (_) {
      return fallback;
    }
  }
}
