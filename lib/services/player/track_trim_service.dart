import 'dart:convert';
import 'dart:math';

import 'package:Bloomee/core/constants/setting_keys.dart';
import 'package:Bloomee/core/models/exported.dart';
import 'package:Bloomee/plugins/utils/media_id.dart';
import 'package:Bloomee/services/db/dao/settings_dao.dart';
import 'package:Bloomee/services/db/db_provider.dart';

class TrackTrimConfig {
  final bool enabled;
  final int startMs;
  final int endMs;
  final int originalDurationMs;
  final String? sourceMediaId;
  final String? renamedTitle;

  const TrackTrimConfig({
    required this.enabled,
    required this.startMs,
    required this.endMs,
    required this.originalDurationMs,
    this.sourceMediaId,
    this.renamedTitle,
  });

  const TrackTrimConfig.disabled({
    this.sourceMediaId,
    this.renamedTitle,
  })  : enabled = false,
        startMs = 0,
        endMs = 0,
        originalDurationMs = 0;

  factory TrackTrimConfig.defaults(
    int originalDurationMs, {
    String? sourceMediaId,
    String? renamedTitle,
  }) {
    final normalizedOriginal = originalDurationMs < 0 ? 0 : originalDurationMs;
    final normalizedTitle = renamedTitle?.trim();
    return TrackTrimConfig(
      enabled: false,
      startMs: 0,
      endMs: normalizedOriginal,
      originalDurationMs: normalizedOriginal,
      sourceMediaId: sourceMediaId,
      renamedTitle:
          (normalizedTitle != null && normalizedTitle.isNotEmpty) ? normalizedTitle : null,
    );
  }

  Duration get start => Duration(milliseconds: startMs);
  Duration get end => Duration(milliseconds: endMs);
  Duration get originalDuration => Duration(milliseconds: originalDurationMs);

  bool get hasCustomTitle =>
      renamedTitle != null && renamedTitle!.trim().isNotEmpty;

  String effectiveTitle(String fallbackTitle) {
    if (hasCustomTitle) return renamedTitle!.trim();
    return fallbackTitle;
  }

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
      if (sourceMediaId != null) 'sourceMediaId': sourceMediaId,
      if (hasCustomTitle) 'renamedTitle': renamedTitle!.trim(),
    };
  }

  factory TrackTrimConfig.fromJson(
    Map<String, dynamic> json, {
    required int fallbackOriginalDurationMs,
    required String fallbackSourceMediaId,
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

    final canEnable = original > 0 && end > start && end <= original;
    final enabled = (json['enabled'] == true) && canEnable;

    if (!canEnable) {
      start = 0;
      end = original;
    }

    final sourceMediaIdRaw = json['sourceMediaId']?.toString().trim();
    final titleRaw = json['renamedTitle']?.toString().trim();

    return TrackTrimConfig(
      enabled: enabled,
      startMs: start,
      endMs: end,
      originalDurationMs: original,
      sourceMediaId: (sourceMediaIdRaw != null && sourceMediaIdRaw.isNotEmpty)
          ? sourceMediaIdRaw
          : fallbackSourceMediaId,
      renamedTitle: (titleRaw != null && titleRaw.isNotEmpty) ? titleRaw : null,
    );
  }

  TrackTrimConfig copyWith({
    bool? enabled,
    int? startMs,
    int? endMs,
    int? originalDurationMs,
    String? sourceMediaId,
    String? renamedTitle,
    bool clearSourceMediaId = false,
    bool clearRenamedTitle = false,
  }) {
    return TrackTrimConfig(
      enabled: enabled ?? this.enabled,
      startMs: startMs ?? this.startMs,
      endMs: endMs ?? this.endMs,
      originalDurationMs: originalDurationMs ?? this.originalDurationMs,
      sourceMediaId:
          clearSourceMediaId ? null : (sourceMediaId ?? this.sourceMediaId),
      renamedTitle: clearRenamedTitle ? null : (renamedTitle ?? this.renamedTitle),
    );
  }
}

class TrackTrimService {
  final SettingsDAO _settingsDao;

  static const String _variantMarker = '@@btv@';

  TrackTrimService({SettingsDAO? settingsDao})
      : _settingsDao = settingsDao ?? SettingsDAO(DBProvider.db);

  String _key(String mediaId) => '${SettingKeys.trackTrimPrefix}:$mediaId';

  static bool isVariantMediaId(String mediaId) {
    final local = localIdOf(mediaId);
    if (local == null) return false;
    return local.contains(_variantMarker);
  }

  static String resolveSourceMediaId(
    String mediaId, {
    String? configuredSourceMediaId,
  }) {
    final explicit = configuredSourceMediaId?.trim();
    if (explicit != null && explicit.isNotEmpty) {
      return explicit;
    }

    final parts = tryParseMediaId(mediaId);
    if (parts == null) return mediaId;

    final markerIdx = parts.localId.indexOf(_variantMarker);
    if (markerIdx <= 0) return mediaId;

    final baseLocalId = parts.localId.substring(0, markerIdx);
    if (baseLocalId.isEmpty) return mediaId;
    return buildMediaId(parts.pluginId, baseLocalId);
  }

  String buildVariantMediaId(String sourceMediaId) {
    final canonicalSource = resolveSourceMediaId(sourceMediaId);
    final parts = tryParseMediaId(canonicalSource);
    if (parts == null) {
      final token =
          '${DateTime.now().microsecondsSinceEpoch}_${Random().nextInt(1 << 32)}';
      return '$canonicalSource$_variantMarker$token';
    }

    final token =
        '${DateTime.now().microsecondsSinceEpoch}_${Random().nextInt(1 << 32)}';
    return buildMediaId(parts.pluginId, '${parts.localId}$_variantMarker$token');
  }

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
    final fallbackSource = resolveSourceMediaId(mediaId);

    if (raw == null || raw.isEmpty) {
      return TrackTrimConfig.defaults(
        fallbackOriginalDurationMs,
        sourceMediaId: fallbackSource,
      );
    }

    try {
      final map = jsonDecode(raw);
      if (map is Map<String, dynamic>) {
        final config = TrackTrimConfig.fromJson(
          map,
          fallbackOriginalDurationMs: fallbackOriginalDurationMs,
          fallbackSourceMediaId: fallbackSource,
        );
        return normalizeConfig(mediaId, config);
      }
      if (map is Map) {
        final config = TrackTrimConfig.fromJson(
          map.map((key, value) => MapEntry('$key', value)),
          fallbackOriginalDurationMs: fallbackOriginalDurationMs,
          fallbackSourceMediaId: fallbackSource,
        );
        return normalizeConfig(mediaId, config);
      }
    } catch (_) {}

    return TrackTrimConfig.defaults(
      fallbackOriginalDurationMs,
      sourceMediaId: fallbackSource,
    );
  }

  TrackTrimConfig normalizeConfig(
    String mediaId,
    TrackTrimConfig config,
  ) {
    final normalizedTitle = (config.renamedTitle?.trim().isNotEmpty ?? false)
        ? config.renamedTitle!.trim()
        : null;
    return config.copyWith(
      sourceMediaId: resolveSourceMediaId(
        mediaId,
        configuredSourceMediaId: config.sourceMediaId,
      ),
      renamedTitle: normalizedTitle,
    );
  }

  Future<void> saveConfig(String mediaId, TrackTrimConfig config) async {
    final normalized = normalizeConfig(mediaId, config);
    await _settingsDao.putSettingStr(_key(mediaId), jsonEncode(normalized.toJson()));
  }

  Track applyToTrack(
    Track track,
    TrackTrimConfig config, {
    String? mediaId,
    String? fallbackSourceMediaId,
  }) {
    final normalizedConfig = normalizeConfig(
      mediaId ?? track.id,
      config,
    ).copyWith(
      sourceMediaId: resolveSourceMediaId(
        mediaId ?? track.id,
        configuredSourceMediaId: config.sourceMediaId ?? fallbackSourceMediaId,
      ),
    );

    final fallbackDuration = track.durationMs?.toInt() ?? 0;
    final durationMs = normalizedConfig.enabled
        ? normalizedConfig.effectiveDurationMs
        : (normalizedConfig.originalDurationMs > 0
            ? normalizedConfig.originalDurationMs
            : fallbackDuration);

    return Track(
      id: mediaId ?? track.id,
      title: normalizedConfig.effectiveTitle(track.title),
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
