import 'package:Bloomee/core/models/exported.dart';
import 'package:Bloomee/core/theme/app_theme.dart';
import 'package:Bloomee/l10n/app_localizations.dart';
import 'package:Bloomee/services/player/track_trim_service.dart';
import 'package:Bloomee/utils/load_image.dart';
import 'package:flutter/material.dart';

Future<TrackTrimConfig?> showTrackTrimDialog(
  BuildContext context, {
  required Track track,
  TrackTrimService? service,
}) {
  return showDialog<TrackTrimConfig>(
    context: context,
    builder: (_) => _TrackTrimDialog(
      track: track,
      service: service ?? TrackTrimService(),
    ),
  );
}

class _TrackTrimDialog extends StatefulWidget {
  final Track track;
  final TrackTrimService service;

  const _TrackTrimDialog({
    required this.track,
    required this.service,
  });

  @override
  State<_TrackTrimDialog> createState() => _TrackTrimDialogState();
}

class _TrackTrimDialogState extends State<_TrackTrimDialog> {
  late final TextEditingController _startController;
  late final TextEditingController _endController;

  Duration _originalDuration = Duration.zero;
  Duration? _newDuration;
  String? _errorMessage;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _startController = TextEditingController();
    _endController = TextEditingController();
    _startController.addListener(_recomputeDuration);
    _endController.addListener(_recomputeDuration);
    _loadTrim();
  }

  Future<void> _loadTrim() async {
    final fallbackMs = widget.track.durationMs?.toInt() ?? 0;
    final config = await widget.service.getConfigForTrack(widget.track);
    if (!mounted) return;

    final originalMs = config.originalDurationMs > 0
        ? config.originalDurationMs
        : (fallbackMs > 0 ? fallbackMs : 0);

    _originalDuration = Duration(milliseconds: originalMs);
    _startController.text = _formatClock(Duration(milliseconds: config.startMs));
    _endController.text = _formatClock(Duration(milliseconds: config.endMs));
    _recomputeDuration();

    setState(() {
      _loading = false;
    });
  }

  Duration? _parseDurationInput(String input) {
    final text = input.trim();
    if (text.isEmpty) return null;

    final secondValue = int.tryParse(text);
    if (secondValue != null) {
      if (secondValue < 0) return null;
      return Duration(seconds: secondValue);
    }

    final parts = text.split(':');
    if (parts.length != 2 && parts.length != 3) return null;

    final values = parts.map((part) => int.tryParse(part.trim())).toList();
    if (values.any((value) => value == null || value! < 0)) return null;

    if (parts.length == 2) {
      final minutes = values[0]!;
      final seconds = values[1]!;
      if (seconds >= 60) return null;
      return Duration(minutes: minutes, seconds: seconds);
    }

    final hours = values[0]!;
    final minutes = values[1]!;
    final seconds = values[2]!;
    if (minutes >= 60 || seconds >= 60) return null;
    return Duration(hours: hours, minutes: minutes, seconds: seconds);
  }

  String _formatClock(Duration duration) {
    final safe = duration < Duration.zero ? Duration.zero : duration;
    final totalSeconds = safe.inSeconds;
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }

    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _recomputeDuration() {
    final start = _parseDurationInput(_startController.text);
    final end = _parseDurationInput(_endController.text);

    if (!mounted) return;

    if (start == null || end == null) {
      setState(() {
        _newDuration = null;
        _errorMessage = null;
      });
      return;
    }

    final duration = end - start;
    setState(() {
      _newDuration = duration > Duration.zero ? duration : Duration.zero;
      _errorMessage = null;
    });
  }

  Future<void> _onConfirm() async {
    final l10n = AppLocalizations.of(context)!;
    final start = _parseDurationInput(_startController.text);
    final end = _parseDurationInput(_endController.text);

    if (start == null || end == null) {
      setState(() => _errorMessage = l10n.trackTrimErrorInvalidFormat);
      return;
    }

    if (_originalDuration <= Duration.zero) {
      setState(() => _errorMessage = l10n.trackTrimErrorMissingDuration);
      return;
    }

    if (end > _originalDuration) {
      setState(() => _errorMessage = l10n.trackTrimErrorEndOutOfBounds);
      return;
    }

    final isDefault = start == Duration.zero && end == _originalDuration;
    if (!isDefault && end <= start) {
      setState(() => _errorMessage = l10n.trackTrimErrorEndBeforeStart);
      return;
    }

    final config = TrackTrimConfig(
      enabled: !isDefault,
      startMs: isDefault ? 0 : start.inMilliseconds,
      endMs: isDefault ? _originalDuration.inMilliseconds : end.inMilliseconds,
      originalDurationMs: _originalDuration.inMilliseconds,
    );

    if (!mounted) return;
    Navigator.of(context).pop(config);
  }

  @override
  void dispose() {
    _startController.dispose();
    _endController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final artists = widget.track.artists.map((a) => a.name).join(', ');

    return Dialog(
      backgroundColor: Default_Theme.themeColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: _loading
              ? const SizedBox(
                  height: 220,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Default_Theme.accentColor2,
                    ),
                  ),
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.trackTrimTitle,
                      style: Default_Theme.secondoryTextStyle.merge(
                        const TextStyle(
                          color: Default_Theme.primaryColor1,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: SizedBox(
                        height: 90,
                        width: 90,
                        child: LoadImageCached(
                          imageUrl: widget.track.thumbnail.urlLow ??
                              widget.track.thumbnail.url,
                          fallbackUrl: widget.track.thumbnail.url,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.track.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: Default_Theme.secondoryTextStyle.merge(
                        const TextStyle(
                          color: Default_Theme.primaryColor1,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      artists.isEmpty ? l10n.playerUnknownQueue : artists,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: Default_Theme.secondoryTextStyle.merge(
                        TextStyle(
                          color: Default_Theme.primaryColor1
                              .withValues(alpha: 0.7),
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${l10n.trackTrimOriginalDuration}: ${_formatClock(_originalDuration)}',
                      style: Default_Theme.secondoryTextStyle.merge(
                        TextStyle(
                          color: Default_Theme.primaryColor1
                              .withValues(alpha: 0.8),
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      controller: _startController,
                      keyboardType: TextInputType.datetime,
                      style: const TextStyle(color: Default_Theme.primaryColor1),
                      decoration: InputDecoration(
                        labelText: l10n.trackTrimStartLabel,
                        hintText: l10n.trackTrimInputHint,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _endController,
                      keyboardType: TextInputType.datetime,
                      style: const TextStyle(color: Default_Theme.primaryColor1),
                      decoration: InputDecoration(
                        labelText: l10n.trackTrimEndLabel,
                        hintText: l10n.trackTrimInputHint,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '${l10n.trackTrimNewDuration}: ${_newDuration != null ? _formatClock(_newDuration!) : '--:--'}',
                      style: Default_Theme.secondoryTextStyle.merge(
                        const TextStyle(
                          color: Default_Theme.primaryColor1,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (_errorMessage != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        _errorMessage!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.redAccent,
                          fontSize: 12,
                        ),
                      ),
                    ],
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(l10n.trackTrimCancel),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _onConfirm,
                            child: Text(l10n.trackTrimOk),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
