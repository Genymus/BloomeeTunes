// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:Bloomee/blocs/media_player/bloomee_player_cubit.dart';
import 'package:Bloomee/blocs/settings_cubit/cubit/settings_cubit.dart';
import 'package:Bloomee/core/theme/app_theme.dart';
import 'package:Bloomee/screens/screen/home_views/setting_views/setting_shared_widgets.dart';
import 'package:Bloomee/screens/screen/player_views/equalizer_view.dart';
import 'package:Bloomee/services/player/notification_player_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Bloomee/l10n/app_localizations.dart';
import 'package:icons_plus/icons_plus.dart';

class PlayerSettings extends StatelessWidget {
  const PlayerSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Default_Theme.themeColor,
      appBar: AppBar(
        backgroundColor: Default_Theme.themeColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 64,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Center(
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Default_Theme.primaryColor1,
                size: 24,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: Text(
          l10n.playerSettingTitle,
          style: const TextStyle(
            color: Default_Theme.primaryColor1,
            fontSize: 22,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ).merge(Default_Theme.secondoryTextStyleMedium),
        ),
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        buildWhen: (prev, curr) =>
            prev.strmQuality != curr.strmQuality ||
            prev.autoPlay != curr.autoPlay ||
            prev.autoResolveUnavailableTracks !=
                curr.autoResolveUnavailableTracks ||
            prev.crossfadeDuration != curr.crossfadeDuration ||
            prev.eqEnabled != curr.eqEnabled ||
            prev.eqPreset != curr.eqPreset,
        builder: (context, state) {
          return ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            children: [
              // ─── Streaming Quality ─────────────────────────────────────
              SettingSectionHeader(label: l10n.playerSettingStreamingHeader),
              SettingCard(
                children: [
                  SettingQualityChipRow(
                    icon: MingCute.cellphone_vibration_line,
                    title: l10n.playerSettingStreamQuality,
                    subtitle: l10n.playerSettingStreamQualitySubtitle,
                    options: [
                      l10n.playerSettingQualityLow,
                      l10n.playerSettingQualityMedium,
                      l10n.playerSettingQualityHigh,
                    ],
                    selected: state.strmQuality,
                    onSelected: (v) =>
                        context.read<SettingsCubit>().setStrmQuality(v),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // ─── Playback ──────────────────────────────────────────────
              SettingSectionHeader(label: l10n.playerSettingPlaybackHeader),
              SettingCard(
                children: [
                  SettingToggleTile(
                    icon: MingCute.music_2_line,
                    title: l10n.playerSettingAutoPlay,
                    subtitle: l10n.playerSettingAutoPlaySubtitle,
                    value: state.autoPlay,
                    onChanged: (v) =>
                        context.read<SettingsCubit>().setAutoPlay(v),
                  ),
                  const SettingDivider(),
                  SettingToggleTile(
                    icon: MingCute.search_2_line,
                    title: l10n.playerSettingAutoFallback,
                    subtitle: l10n.playerSettingAutoFallbackSubtitle,
                    value: state.autoResolveUnavailableTracks,
                    onChanged: (v) => context
                        .read<SettingsCubit>()
                        .setAutoResolveUnavailableTracks(v),
                  ),
                  const SettingDivider(),
                  _CrossfadeSlider(
                    value: state.crossfadeDuration,
                    onChanged: (v) {
                      context.read<SettingsCubit>().setCrossfadeDuration(v);
                      context
                          .read<BloomeePlayerCubit>()
                          .bloomeePlayer
                          .setCrossfadeDuration(Duration(seconds: v));
                    },
                  ),
                  const SettingDivider(),
                  SettingNavTile(
                    icon: Icons.equalizer_rounded,
                    title: l10n.playerSettingEqualizer,
                    subtitle: state.eqEnabled
                        ? l10n
                            .playerSettingEqualizerActivePreset(state.eqPreset)
                        : l10n.playerSettingEqualizerSubtitle,
                    badge: state.eqEnabled
                        ? l10n.playerSettingEqualizerActive
                        : null,
                    roundBottom: true,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const EqualizerView()),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              SettingSectionHeader(
                  label: l10n.playerSettingNotificationControlsHeader),
              SettingCard(
                children: const [
                  _NotificationControlsCard(),
                ],
              ),

              const SizedBox(height: 40),
            ],
          );
        },
      ),
    );
  }
}

// ─── Crossfade Slider ────────────────────────────────────────────────────────

class _CrossfadeSlider extends StatefulWidget {
  final int value;
  final ValueChanged<int> onChanged;

  const _CrossfadeSlider({required this.value, required this.onChanged});

  @override
  State<_CrossfadeSlider> createState() => _CrossfadeSliderState();
}

class _CrossfadeSliderState extends State<_CrossfadeSlider> {
  late double _localValue;

  @override
  void initState() {
    super.initState();
    _localValue = widget.value.toDouble();
  }

  @override
  void didUpdateWidget(_CrossfadeSlider old) {
    super.didUpdateWidget(old);
    if (old.value != widget.value) {
      _localValue = widget.value.toDouble();
    }
  }

  class _NotificationControlsCard extends StatefulWidget {
    const _NotificationControlsCard();

    @override
    State<_NotificationControlsCard> createState() =>
        _NotificationControlsCardState();
  }

  class _NotificationControlsCardState extends State<_NotificationControlsCard> {
    bool _loading = true;
    List<NotificationPlayerControlPreference> _items = const [];

    @override
    void initState() {
      super.initState();
      _load();
    }

    Future<void> _load() async {
      final player = context.read<BloomeePlayerCubit>().bloomeePlayer;
      final loaded = await player.loadNotificationPlayerControls();
      if (!mounted) return;
      setState(() {
        _items = List<NotificationPlayerControlPreference>.from(loaded);
        _loading = false;
      });
    }

    Future<void> _persist() async {
      final player = context.read<BloomeePlayerCubit>().bloomeePlayer;
      await player.updateNotificationPlayerControls(_items);
    }

    IconData _iconForAction(NotificationPlayerControlAction action) {
      return switch (action) {
        NotificationPlayerControlAction.playPause => MingCute.play_fill,
        NotificationPlayerControlAction.previous => Icons.skip_previous_rounded,
        NotificationPlayerControlAction.next => Icons.skip_next_rounded,
        NotificationPlayerControlAction.addToLiked => MingCute.heart_fill,
        NotificationPlayerControlAction.addToPlaylist => MingCute.playlist_add_line,
        NotificationPlayerControlAction.repeat => Icons.repeat_rounded,
        NotificationPlayerControlAction.shuffle => Icons.shuffle_rounded,
        NotificationPlayerControlAction.restartFromBeginning =>
          Icons.replay_rounded,
      };
    }

    String _labelForAction(
      BuildContext context,
      NotificationPlayerControlAction action,
    ) {
      final l10n = AppLocalizations.of(context)!;
      return switch (action) {
        NotificationPlayerControlAction.playPause =>
          l10n.playerSettingNotificationControlPlayPause,
        NotificationPlayerControlAction.previous =>
          l10n.playerSettingNotificationControlPrevious,
        NotificationPlayerControlAction.next =>
          l10n.playerSettingNotificationControlNext,
        NotificationPlayerControlAction.addToLiked =>
          l10n.playerSettingNotificationControlAddToLiked,
        NotificationPlayerControlAction.addToPlaylist =>
          l10n.playerSettingNotificationControlAddToPlaylist,
        NotificationPlayerControlAction.repeat =>
          l10n.playerSettingNotificationControlRepeat,
        NotificationPlayerControlAction.shuffle =>
          l10n.playerSettingNotificationControlShuffle,
        NotificationPlayerControlAction.restartFromBeginning =>
          l10n.playerSettingNotificationControlRestartFromBeginning,
      };
    }

    @override
    Widget build(BuildContext context) {
      final l10n = AppLocalizations.of(context)!;
      if (_loading) {
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: Center(
            child: CircularProgressIndicator(color: Default_Theme.accentColor2),
          ),
        );
      }

      return Padding(
        padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                l10n.playerSettingNotificationControlsSubtitle,
                style: Default_Theme.secondoryTextStyle.copyWith(
                  color: Default_Theme.primaryColor2.withValues(alpha: 0.55),
                  fontSize: 13,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ReorderableListView.builder(
              shrinkWrap: true,
              buildDefaultDragHandles: false,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _items.length,
              onReorder: (oldIndex, newIndex) async {
                setState(() {
                  if (newIndex > oldIndex) newIndex--;
                  final item = _items.removeAt(oldIndex);
                  _items.insert(newIndex, item);
                });
                await _persist();
              },
              itemBuilder: (context, index) {
                final item = _items[index];
                return Container(
                  key: ValueKey(item.action.name),
                  margin: EdgeInsets.only(bottom: index == _items.length - 1 ? 0 : 8),
                  decoration: BoxDecoration(
                    color: Default_Theme.primaryColor2.withValues(alpha: 0.03),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Default_Theme.primaryColor2.withValues(alpha: 0.08),
                    ),
                  ),
                  child: Row(
                    children: [
                      Checkbox(
                        value: item.enabled,
                        activeColor: Default_Theme.accentColor2,
                        onChanged: (value) async {
                          final enabled = value ?? false;
                          setState(() {
                            _items[index] = item.copyWith(enabled: enabled);
                          });
                          await _persist();
                        },
                      ),
                      Icon(
                        _iconForAction(item.action),
                        color: Default_Theme.primaryColor2.withValues(alpha: 0.8),
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _labelForAction(context, item.action),
                          style: Default_Theme.secondoryTextStyleMedium.copyWith(
                            color: Default_Theme.primaryColor2,
                            fontSize: 14.5,
                          ),
                        ),
                      ),
                      ReorderableDragStartListener(
                        index: index,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(
                            Icons.drag_handle_rounded,
                            color: Default_Theme.accentColor2,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final description = _localValue == 0
        ? l10n.playerSettingCrossfadeInstant
        : l10n.playerSettingCrossfadeBlend(_localValue.toInt());
    final offLabel = l10n.playerSettingCrossfadeOff;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SettingIconBox(icon: Icons.graphic_eq_rounded),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.playerSettingCrossfade,
                      style: const TextStyle(
                        color: Default_Theme.primaryColor2,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.2,
                      ).merge(Default_Theme.secondoryTextStyleMedium),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        color:
                            Default_Theme.primaryColor2.withValues(alpha: 0.5),
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ).merge(Default_Theme.secondoryTextStyle),
                    ),
                  ],
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 180),
                transitionBuilder: (child, anim) =>
                    FadeTransition(opacity: anim, child: child),
                child: _localValue == 0
                    ? Text(
                        offLabel,
                        key: const ValueKey('off'),
                        style: TextStyle(
                          color: Default_Theme.primaryColor2
                              .withValues(alpha: 0.4),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ).merge(Default_Theme.secondoryTextStyleMedium),
                      )
                    : Text(
                        '${_localValue.toInt()}s',
                        key: ValueKey(_localValue.toInt()),
                        style: const TextStyle(
                          color: Default_Theme.accentColor2,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ).merge(Default_Theme.secondoryTextStyleMedium),
                      ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 4,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 18),
              activeTrackColor: Default_Theme.accentColor2,
              inactiveTrackColor:
                  Default_Theme.primaryColor2.withValues(alpha: 0.1),
              thumbColor: Default_Theme.accentColor2,
              overlayColor: Default_Theme.accentColor2.withValues(alpha: 0.15),
              tickMarkShape:
                  const RoundSliderTickMarkShape(tickMarkRadius: 2.5),
              activeTickMarkColor:
                  Default_Theme.themeColor.withValues(alpha: 0.5),
              inactiveTickMarkColor:
                  Default_Theme.primaryColor2.withValues(alpha: 0.2),
            ),
            child: Slider(
              min: 0,
              max: 12,
              divisions: 6,
              value: _localValue,
              onChanged: (v) => setState(() => _localValue = v),
              onChangeEnd: (v) => widget.onChanged(v.toInt()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [0, 2, 4, 6, 8, 10, 12].map((v) {
                final active = _localValue.toInt() == v;
                return Text(
                  v == 0 ? offLabel : '${v}s',
                  style: TextStyle(
                    color: active
                        ? Default_Theme.accentColor2
                        : Default_Theme.primaryColor2.withValues(alpha: 0.3),
                    fontSize: 11,
                    fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                  ).merge(Default_Theme.secondoryTextStyle),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
