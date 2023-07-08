import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:shamchiroq/models/style.dart';

class AudioList extends StatefulWidget {
  AudioList(
      {Key? key, required this.url, required this.isAsset, required this.text})
      : super(key: key);
  final String url;
  final bool isAsset;
  final String text;
  @override
  State<AudioList> createState() => _AudioListState();
}

class _AudioListState extends State<AudioList> {
  late AudioPlayer audioPlayer;
  late AudioCache audioCache;
  String playIcon = "assets/images/play.svg";
  String stopIcon = "assets/images/stop-col.svg";
  PlayerState _playerState = PlayerState.STOPPED;
  bool get isPlaying => _playerState == PlayerState.PLAYING;
  bool get isLocal => !widget.url.contains('https');
  @override
  void initState() {
    audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
    audioCache = AudioCache(fixedPlayer: audioPlayer);

    audioPlayer.onPlayerError.listen((msg) {
      print('audioPlayer error : $msg');
      setState(() {
        _playerState = PlayerState.STOPPED;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  _playPause() async {
    if (_playerState == PlayerState.PLAYING) {
      final playerResult = await audioPlayer.pause();
      if (playerResult == 1) {
        setState(() {
          _playerState = PlayerState.PAUSED;
        });
      }
    } else if (_playerState == PlayerState.PAUSED) {
      final playerResult = await audioPlayer.resume();
      if (playerResult == 1) {
        setState(() {
          _playerState = PlayerState.PLAYING;
        });
      }
    } else {
      if (widget.isAsset) {
        Uint8List soundbytes =
            (await NetworkAssetBundle(Uri.parse(widget.url)).load(widget.url))
                .buffer
                .asUint8List();
        audioPlayer = await audioCache.playBytes(soundbytes);
        setState(() {
          _playerState = PlayerState.PLAYING;
        });
      } else {
        final playerResult =
            await audioPlayer.play(widget.url, isLocal: isLocal);
        if (playerResult == 1) {
          setState(() {
            _playerState = PlayerState.PLAYING;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        height: 85,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: Text(
            widget.text,
            style: TextStyle(
                fontSize: 15,
                fontFamily: kRoboto,
                color: const Color.fromARGB(255, 107, 107, 107)),
          ),
          trailing: GestureDetector(
            onTap: () async {
              setState(() {
                playIcon = "assets/images/play.svg";
                stopIcon = "assets/images/stop-col.svg";
              });
              _playPause();
              audioPlayer.onPlayerCompletion.listen((event) {
                setState(() {
                  stopIcon = playIcon;
                });
              });
            },
            child: Container(
              alignment: Alignment.center,
              width: 55,
              height: 55,
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(94, 114, 228, 0.13),
                  shape: BoxShape.circle),
              child: widget.url != null
                  ? SvgPicture.asset(isPlaying
                      ? stopIcon
                      : playIcon)
                  : CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
