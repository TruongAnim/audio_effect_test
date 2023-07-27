import 'package:flutter/material.dart';

class TimerWidget extends StatelessWidget {
  final Color color;
  final bool isRecord;
  final Duration duration;
  const TimerWidget(
      {super.key,
      required this.duration,
      required this.color,
      required this.isRecord});
  String _formatDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isRecord
            ? Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: duration.inSeconds % 2 == 0
                      ? Colors.red
                      : Colors.transparent,
                ),
              )
            : const SizedBox(),
        const SizedBox(width: 3),
        Text(
          _formatDuration(duration),
          style: TextStyle(color: color, fontSize: isRecord ? 16 : 14),
        ),
      ],
    );
  }
}
