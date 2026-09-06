import 'package:Bloomee/blocs/settings_cubit/cubit/settings_cubit.dart';
import 'package:Bloomee/core/di/service_locator.dart';
import 'package:Bloomee/plugins/blocs/chart/chart_bloc.dart';
import 'package:Bloomee/plugins/blocs/chart/chart_event.dart';
import 'package:Bloomee/plugins/blocs/chart/chart_state.dart';
import 'package:Bloomee/plugins/blocs/plugin/plugin_bloc.dart';

import 'package:Bloomee/repository/LastFM/lastfmapi.dart';
import 'package:Bloomee/screens/screen/home_views/setting_views/setting_shared_widgets.dart';
import 'package:Bloomee/screens/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:Bloomee/core/theme/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Bloomee/l10n/app_localizations.dart';
import 'package:icons_plus/icons_plus.dart';

class AppUISettings extends StatefulWidget {
  const AppUISettings({super.key});

  @override
  State<AppUISettings> createState() => _AppUISettingsState();
}

class _AppUISettingsState extends State<AppUISettings> {
  late final ChartBloc _chartBloc;

  @override
  void initState() {
    super.initState();
    _chartBloc = ChartBloc(
      pluginService: ServiceLocator.pluginService,
    );
    _loadCharts();
  }

  void _loadCharts() {
    final chartProviders =
        context.read<PluginBloc>().state.loadedChartProviders;
    if (chartProviders.isNotEmpty) {
      _chartBloc.add(LoadCharts(pluginId: chartProviders.first.manifest.id));
    }
  }

  @override
  void dispose() {
    _chartBloc.close();
    super.dispose();
  }

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
          l10n.appuiTitle,
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
            prev.autoSlideCharts != curr.autoSlideCharts ||
            prev.lFMPicks != curr.lFMPicks ||
            prev.chartMap != curr.chartMap ||
            prev.androidBackPressExitConfirmEnabled !=
                curr.androidBackPressExitConfirmEnabled ||
            prev.androidBackPressExitConfirmTimeoutMs !=
                curr.androidBackPressExitConfirmTimeoutMs,
        builder: (context, state) {
          return ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            children: [
              SettingSectionHeader(label: l10n.settingsHomeScreen),
              SettingCard(
                children: [
                  SettingToggleTile(
                    icon: MingCute.play_circle_line,
                    title: l10n.appuiAutoSlideCharts,
                    subtitle: l10n.appuiAutoSlideChartsSubtitle,
                    value: state.autoSlideCharts,
                    onChanged: (v) =>
                        context.read<SettingsCubit>().setAutoSlideCharts(v),
                  ),
                  const SettingDivider(),
                  SettingToggleTile(
                    icon: MingCute.music_2_line,
                    title: l10n.exploreLastFmPicks,
                    subtitle: l10n.appuiLastFmPicksSubtitle,
                    value: state.lFMPicks,
                    onChanged: (v) {
                      context.read<SettingsCubit>().setLastFMExpore(v);
                      if (v && LastFmAPI.initialized == false) {
                        Future.delayed(const Duration(milliseconds: 500), () {
                          context.read<SettingsCubit>().setLastFMExpore(false);
                        });
                        SnackbarService.showMessage(l10n.appuiLoginToLastFm);
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 28),
              SettingSectionHeader(label: l10n.appuiBackPressExitSectionTitle),
              SettingCard(
                children: [
                  SettingToggleTile(
                    icon: Icons.exit_to_app_rounded,
                    title: l10n.appuiBackPressExitToggleTitle,
                    subtitle: l10n.appuiBackPressExitToggleSubtitle,
                    value: state.androidBackPressExitConfirmEnabled,
                    onChanged: (v) => context
                        .read<SettingsCubit>()
                        .setAndroidBackPressExitConfirmEnabled(v),
                    roundBottom: !state.androidBackPressExitConfirmEnabled,
                  ),
                  if (state.androidBackPressExitConfirmEnabled) ...[
                    const SettingDivider(),
                    _BackExitConfirmTimeoutSlider(
                      valueMs: state.androidBackPressExitConfirmTimeoutMs,
                      onChanged: (timeoutMs) => context
                          .read<SettingsCubit>()
                          .setAndroidBackPressExitConfirmTimeoutMs(timeoutMs),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 28),
              SettingSectionHeader(label: l10n.settingsChartVisibility),
              BlocBuilder<ChartBloc, ChartState>(
                bloc: _chartBloc,
                builder: (context, chartState) {
                  if (chartState.charts.isEmpty) {
                    return SettingCard(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          child: Row(
                            children: [
                              const SettingIconBox(
                                  icon: MingCute.chart_bar_line),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Text(
                                  l10n.appuiNoChartsAvailable,
                                  style: TextStyle(
                                    color: Default_Theme.primaryColor2
                                        .withValues(alpha: 0.5),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ).merge(Default_Theme.secondoryTextStyle),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return SettingCard(
                    children: [
                      for (var i = 0; i < chartState.charts.length; i++) ...[
                        if (i > 0) const SettingDivider(),
                        SettingToggleTile(
                          icon: MingCute.chart_bar_line,
                          title: chartState.charts[i].title,
                          subtitle: l10n.appuiShowInCarousel,
                          value: state.chartMap[chartState.charts[i].title] ??
                              true,
                          onChanged: (v) {
                            context
                                .read<SettingsCubit>()
                                .setChartShow(chartState.charts[i].title, v);
                          },
                        ),
                      ],
                    ],
                  );
                },
              ),
              const SizedBox(height: 40),
            ],
          );
        },
      ),
    );
  }
}

class _BackExitConfirmTimeoutSlider extends StatefulWidget {
  final int valueMs;
  final ValueChanged<int> onChanged;

  const _BackExitConfirmTimeoutSlider({
    required this.valueMs,
    required this.onChanged,
  });

  @override
  State<_BackExitConfirmTimeoutSlider> createState() =>
      _BackExitConfirmTimeoutSliderState();
}

class _BackExitConfirmTimeoutSliderState
    extends State<_BackExitConfirmTimeoutSlider> {
  static const double _minSeconds = 1;
  static const double _maxSeconds = 5;
  late double _seconds;

  @override
  void initState() {
    super.initState();
    _seconds = (widget.valueMs / 1000).clamp(_minSeconds, _maxSeconds).toDouble();
  }

  @override
  void didUpdateWidget(covariant _BackExitConfirmTimeoutSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.valueMs != widget.valueMs) {
      _seconds =
          (widget.valueMs / 1000).clamp(_minSeconds, _maxSeconds).toDouble();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SettingIconBox(icon: Icons.timer_outlined),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.appuiBackPressExitTimeoutTitle,
                      style: const TextStyle(
                        color: Default_Theme.primaryColor2,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.2,
                      ).merge(Default_Theme.secondoryTextStyleMedium),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.appuiBackPressExitTimeoutSubtitle(_seconds.toInt()),
                      style: TextStyle(
                        color: Default_Theme.primaryColor2.withValues(alpha: 0.5),
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ).merge(Default_Theme.secondoryTextStyle),
                    ),
                  ],
                ),
              ),
              Text(
                '${_seconds.toInt()}s',
                style: const TextStyle(
                  color: Default_Theme.accentColor2,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ).merge(Default_Theme.secondoryTextStyleMedium),
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
            ),
            child: Slider(
              min: _minSeconds,
              max: _maxSeconds,
              divisions: (_maxSeconds - _minSeconds).toInt(),
              value: _seconds,
              onChanged: (v) => setState(() => _seconds = v),
              onChangeEnd: (v) => widget.onChanged(v.toInt() * 1000),
            ),
          ),
        ],
      ),
    );
  }
}
