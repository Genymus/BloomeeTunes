import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class AutoScrollingSingleLineText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign textAlign;
  final double velocity;
  final Duration pauseAfterRound;
  final Duration startAfter;
  final double blankSpace;

  const AutoScrollingSingleLineText({
    super.key,
    required this.text,
    this.style,
    this.textAlign = TextAlign.start,
    this.velocity = 32,
    this.pauseAfterRound = const Duration(seconds: 2),
    this.startAfter = const Duration(seconds: 1),
    this.blankSpace = 24,
  });

  @override
  Widget build(BuildContext context) {
    if (text.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    final resolvedStyle = DefaultTextStyle.of(context).style.merge(style);

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        if (maxWidth <= 0) {
          return const SizedBox.shrink();
        }

        final textPainter = TextPainter(
          text: TextSpan(text: text, style: resolvedStyle),
          maxLines: 1,
          textDirection: Directionality.of(context),
        )..layout(minWidth: 0, maxWidth: double.infinity);

        final shouldScroll = textPainter.width > maxWidth;

        if (!shouldScroll) {
          return Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.visible,
            softWrap: false,
            textAlign: textAlign,
            style: resolvedStyle,
          );
        }

        return SizedBox(
          width: maxWidth,
          child: Marquee(
            text: text,
            style: resolvedStyle,
            velocity: velocity,
            blankSpace: blankSpace,
            pauseAfterRound: pauseAfterRound,
            startAfter: startAfter,
            textDirection: Directionality.of(context),
            textAlign: textAlign,
            scrollAxis: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        );
      },
    );
  }
}
