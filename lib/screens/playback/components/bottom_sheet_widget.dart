import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'equalizer_controller_widget.dart';
import 'loudness_controller_widget.dart';

class BotttomSheetWidget extends StatefulWidget {
  final AndroidEqualizer equalizer;
  final AndroidLoudnessEnhancer loudness;
  const BotttomSheetWidget(
      {super.key, required this.equalizer, required this.loudness});

  @override
  State<BotttomSheetWidget> createState() => _BotttomSheetWidgetState();
}

class _BotttomSheetWidgetState extends State<BotttomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    final _loudnessEnhancer = widget.loudness;
    final _equalizer = widget.equalizer;
    double h = MediaQuery.of(context).size.height;
    return Container(
      height: h * 0.7,
      color: Color.fromARGB(255, 37, 12, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder<bool>(
            stream: _loudnessEnhancer.enabledStream,
            builder: (context, snapshot) {
              final enabled = snapshot.data ?? false;
              return SwitchListTile(
                title: const Text(
                  'Loudness Enhancer',
                  style: TextStyle(color: Colors.white),
                ),
                value: enabled,
                onChanged: _loudnessEnhancer.setEnabled,
              );
            },
          ),
          LoudnessEnhancerControls(loudnessEnhancer: _loudnessEnhancer),
          StreamBuilder<bool>(
            stream: _equalizer.enabledStream,
            builder: (context, snapshot) {
              final enabled = snapshot.data ?? false;
              return SwitchListTile(
                title: const Text(
                  'Equalizer',
                  style: TextStyle(color: Colors.white),
                ),
                value: enabled,
                onChanged: _equalizer.setEnabled,
              );
            },
          ),
          Expanded(
            child: EqualizerControls(equalizer: _equalizer),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
