import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayScreen extends StatefulWidget {
  const AudioPlayScreen({super.key});

  @override
  State<AudioPlayScreen> createState() => _AudioPlayScreenState();
}

class _AudioPlayScreenState extends State<AudioPlayScreen> {
  int state = 0;
  final player = AudioPlayer(); // Create a player

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }

  Future<void> initPlayer() async {
    final duration = await player.setUrl(// Load a URL
        'https://scummbar.com/mi2/MI1-CD/01%20-%20Opening%20Themes%20-%20Introduction.mp3'); // Schemes: (https: | file: | asset: )
    // player.play();
    player.setPitch(2);
    updateButton(1);
  }

  Widget getIcon() {
    if (state == 0) {
      return const Icon(Icons.stop);
    }
    if (state == 1) {
      return const Icon(Icons.play_arrow);
    }
    return const Icon(Icons.pause);
  }

  void updateButton(int newState) {
    setState(() {
      state = newState;
    });
  }

  void onTap() {
    if (state == 1) {
      player.play();
      updateButton(2);
    } else if (state == 2) {
      player.pause();
      updateButton(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: IconButton(onPressed: onTap, icon: getIcon())),
    );
  }
}
