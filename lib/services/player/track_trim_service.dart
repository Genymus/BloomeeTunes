import 'dart:convert';

import 'package:Bloomee/core/constants/setting_keys.dart';
import 'package:Bloomee/core/models/exported.dart';
import 'package:Bloomee/services/db/dao/settings_dao.dart';
import 'package:Bloomee/services/db/db_provider.dart';

class TrackTrimConfig {
  final bool enabled;
  final int startMs;
  final int endMs;
  final int originalDurationMs;

  const TrackTrimConfig({
    required this.enabled,
    required this.startMs,
    required this.endMs,
    required this.originalDurationMs,
  });

  const TrackTrimConfig.disabled()
      : enabled = false,
        startMs = 0,
        endMs = 0,
        originalDurationMs = 0;

  factory TrackTrimConfig.defaults(int originalDurationMs) {
    final normalizedOriginal = originalDurationMs < 0 ? 0 : originalDurationMs;
    return TrackTrimConfig(
      enabled: false,
      startMs: 0,
      endMs: normalizedOriginal,
      originalDurationMs: normalizedOriginal,
    );
  }

  Duration get start => Duration(milliseconds: startMs);
  Duration get end => Duration(milliseconds: endMs);
  Duration get originalDuration => Duration(milliseconds: originalDurationMs);

  int get effectiveDurationMs {
    if (!enabled) {
      return originalDurationMs;
    }
    final diff = endMs - startMs;
    return diff < 0 ? 0 : diff;
  }

  Duration get effectiveDuration => Duration(milliseconds: effectiveDurationMs);

  Map<String, dynamic> toJson() {
    return {
      'enabled': enabled,
      'startMs': startMs,
      'endMs': endMs,
      'originalDurationMs': originalDurationMs,
    };
  }

  factory TrackTrimConfig.fromJson(
    Map<String, dynamic> json, {
    required int fallbackOriginalDurationMs,
  }) {
    int toInt(dynamic value) {
      if (value is int) return value;
      if (value is num) return value.toInt();
      return int.tryParse(value?.toString() ?? '') ?? 0;
    }

    final rawOriginal = toInt(json['originalDurationMs']);
    final original = rawOriginal > 0
        ? rawOriginal
        : (fallbackOriginalDurationMs > 0 ? fallbackOriginalDurationMs : 0);

    var start = toInt(json['startMs']);
    var end = toInt(json['endMs']);

    if (start < 0) start = 0;
    if (end <= 0 && original > 0) end = original;

    if (original > 0) {
      if (start > original) start = original;
      if (end > original) end = original;
    }

    final enabled = (json['enabled'] == true) &&
        original > 0 &&
        end > start &&
        end <= original;

    if (!enabled) {
      return TrackTrimConfig(
        enabled: false,
        startMs: 0,
        endMs: original,
        originalDurationMs: original,
      );
    }

    return TrackTrimConfig(
      enabled: true,
      startMs: start,
      endMs: end,
      originalDurationMs: original,
    );
  }
}

class TrackTrimService {
  final SettingsDAO _settingsDao;

  TrackTrimService({SettingsDAO? settingsDao})
      : _settingsDao = settingsDao ?? SettingsDAO(DBProvider.db);

  String _key(String mediaId) => '${SettingKeys.trackTrimPrefix}:$mediaId';

  Future<TrackTrimConfig> getConfigForTrack(Track track) {
    return getConfigForMediaId(
      track.id,
      fallbackOriginalDurationMs: track.durationMs?.toInt() ?? 0,
    );
  }

  Future<TrackTrimConfig> getConfigForMediaId(
    String mediaId, {
    required int fallbackOriginalDurationMs,
  }) async {
    final raw = await _settingsDao.getSettingStr(_key(mediaId));
    if (raw == null || raw.isEmpty) {
      return TrackTrimConfig.defaults(fallbackOriginalDurationMs);
    }

    try {
      final map = jsonDecode(raw);
      if (map is Map<String, dynamic>) {
        return TrackTrimConfig.fromJson(
          map,
          fallbackOriginalDurationMs: fallbackOriginalDurationMs,
        );
      }
      if (map is Map) {
        return TrackTrimConfig.fromJson(
          map.map((key, value) => MapEntry('$key', value)),
          fallbackOriginalDurationMs: fallbackOriginalDurationMs,
        );
      }
    } catch (_) {}

    return TrackTrimConfig.defaults(fallbackOriginalDurationMs);
  }

  Future<void> saveConfig(String mediaId, TrackTrimConfig config) async {
    await _settingsDao.putSettingStr(_key(mediaId), jsonEncode(config.toJson()));
  }

  Track applyToTrack(Track track, TrackTrimConfig config) {
    final fallbackDuration = track.durationMs?.toInt() ?? 0;
    final durationMs = config.enabled
        ? config.effectiveDurationMs
        : (config.originalDurationMs > 0
            ? config.originalDurationMs
            : fallbackDuration);

    return Track(
      id: track.id,
      title: track.title,
      artists: track.artists,
      album: track.album,
      durationMs: durationMs > 0 ? BigInt.from(durationMs) : track.durationMs,
      thumbnail: track.thumbnail,
      url: track.url,
      isExplicit: track.isExplicit,
      lyrics: track.lyrics,
    );
  }
}
