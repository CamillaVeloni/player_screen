import 'package:audioplayers/audioplayers.dart';
import 'package:florest_animation/utils/extensions.dart';
import 'package:flutter/material.dart';

import '../widgets/background_animation.dart';
import '../widgets/ficon_button.dart';

const _iconSize = 42.0;
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final String sourceUrl = 'songs/music.mp3';
  late AudioPlayer _audioPlayer;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();

    _audioPlayer = AudioPlayer();
    _audioPlayer.onDurationChanged.listen((Duration d) => setState(() => _duration = d));
    _audioPlayer.onPositionChanged.listen((Duration  p) => setState(() => _position = p));

    _audioPlayer.setSourceAsset(sourceUrl);
  }

  @override
  void dispose() {
    super.dispose();
    _audioPlayer.dispose();
  }

  void _onSkipNext() {}
  void _onSkipPrevious() {}

  void _onPlayPress() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.resume();
      // await _audioPlayer.play(AssetSource('songs/music.mp3'));
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          const BackgroundAnimation(imageUrl: 'assets/images/background.jpg',),
          Positioned(
            top: MediaQuery.of(context).padding.top + 6,
            right: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FIconButton(
                    onPressed: () {},
                    size: 26,
                    icon: const Icon(Icons.close, color: Colors.white),
                    backgroundColor: Colors.black54,
                  ),
                  Row(
                    children: <Widget>[
                      FIconButton(
                        onPressed: () {},
                        size: 26,
                        icon: const Icon(Icons.share, color: Colors.white),
                        backgroundColor: Colors.black54,
                      ),
                      FIconButton(
                        onPressed: () {},
                        size: 26,
                        icon: const Icon(Icons.download_rounded,
                            color: Colors.white),
                        backgroundColor: Colors.black54,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text(
                  'Gentle Tune',
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                  ),
                ),
                Text('Meditation track',
                    style: TextStyle(fontSize: 17, color: Colors.white70),),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/images/pine_tree.png',
              opacity: const AlwaysStoppedAnimation(.7),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset('assets/images/lovepik_deer.png',
                color: Colors.black),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.skip_previous,
                            color: Colors.white, size: _iconSize),
                        onPressed: _onSkipPrevious,
                      ),
                      IconButton(
                        icon: _isPlaying
                            ? const Icon(Icons.pause,
                                color: Colors.white, size: _iconSize)
                            : const Icon(Icons.play_arrow, color: Colors.white, size: _iconSize),
                        onPressed: _onPlayPress,
                      ),
                      IconButton(
                        icon: const Icon(Icons.skip_next, color: Colors.white, size: _iconSize),
                        onPressed: _onSkipNext,
                      ),
                    ],
                  ),
                  Slider(
                    value: _position.inSeconds.toDouble(),
                    min: 0,
                    activeColor: Colors.white,
                    inactiveColor: Colors.white54,
                    secondaryActiveColor: Colors.white,
                    max: _duration.inSeconds.toDouble(),
                    onChanged: (value) async {},
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_position.formatTime(), style: const TextStyle(color: Colors.white70,),),
                        Text(_duration.formatTime(), style: const TextStyle(color: Colors.white70,),)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
