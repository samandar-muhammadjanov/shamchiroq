// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:shamchiroq/api/api.dart';
import 'package:shamchiroq/models/style.dart';
// import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:pdf_text/pdf_text.dart';
import 'package:shamchiroq/sizeconfige.dart';
import 'package:shamchiroq/widgets/custom_paint.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Pdf extends StatefulWidget {
  final File file;
  const Pdf({Key? key, required this.file}) : super(key: key);

  @override
  State<Pdf> createState() => _PdfState();
}

class _PdfState extends State<Pdf> {
  List url = Hive.box("url").get(0) ?? [];
  String scannedText = '';
  List pdfAudio = [];
  late AudioPlayer audioPlayer;
  late AudioCache audioCache;
  String playIcon = "assets/images/play_outlined.svg";
  String stopIcon = "assets/images/stop-col.svg";
  PlayerState _playerState = PlayerState.STOPPED;
  bool get isPlaying => _playerState == PlayerState.PLAYING;
  bool get isLocal => url.contains('https');
  bool isAssets = false;
  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
    audioCache = AudioCache(fixedPlayer: audioPlayer);

    audioPlayer.onPlayerError.listen((msg) {
      print('audioPlayer error : $msg');
      setState(() {
        _playerState = PlayerState.STOPPED;
      });
    });
    pdfText();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kbackground,
      appBar: appBarWithAction(context),
      body: SizedBox(
        height: size.height,
        child: Stack(
          children: [
            pdfAudio.isNotEmpty
                ? PdfView(path: widget.file.path)
                : Center(child: CircularProgressIndicator()),
            Positioned(
              bottom: 0,
              left: 0,
              child: SizedBox(
                width: size.width,
                child: Stack(
                  children: [
                    CustomPaint(
                      size: Size(
                          size.width,
                          (size.width * 0.42028985507246375)
                              .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                      painter: RPSCustomPainter(),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 23.0,
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              playIcon = "assets/images/play_outlined.svg";
                              stopIcon = "assets/images/stop.svg";
                            });
                            _playPause();
                            audioPlayer.onPlayerCompletion.listen((event) {
                              setState(() {
                                stopIcon = playIcon;
                              });
                            });
                          },
                          child:
                              SvgPicture.asset(isPlaying ? stopIcon : playIcon),
                          style: ElevatedButton.styleFrom(
                            primary: kColor,
                            shadowColor:
                                const Color.fromRGBO(195, 200, 239, 0.21),
                            elevation: 60,
                            minimumSize: const Size(85, 85),
                            maximumSize: const Size(85, 85),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.white, width: 4),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      width: MediaQuery.of(context).size.width,
                      bottom: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: SvgPicture.asset("assets/images/p_left.svg"),
                            style: ButtonStyle(
                              overlayColor:
                                  MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return Colors.grey.withOpacity(0.4);
                                  } //<-- SEE HERE
                                  return null; // Defer to the widget's default.
                                },
                              ),
                              shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.elliptical(120, 40),
                                    topRight: Radius.elliptical(30, 20),
                                  ),
                                ),
                              ),
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              minimumSize: MaterialStateProperty.all(
                                Size(
                                  wi(138),
                                  he(97),
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                print(pdfAudio[0][0]);
                              },
                              child:
                                  SvgPicture.asset("assets/images/p_right.svg"),
                              style: ButtonStyle(
                                  overlayColor:
                                      MaterialStateProperty.resolveWith<Color?>(
                                    (Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.pressed)) {
                                        return Colors.grey.withOpacity(0.4);
                                      } //<-- SEE HERE
                                      return null; // Defer to the widget's default.
                                    },
                                  ),
                                  shape: MaterialStateProperty.all(
                                      const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft:
                                                  Radius.elliptical(30, 20),
                                              topRight:
                                                  Radius.elliptical(120, 40)))),
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  minimumSize: MaterialStateProperty.all(
                                      Size(wi(138), he(97))))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

//
//
//
//  Services for pdf ↓
//
//
//

  void pdfText() async {
    PDFDoc doc = await PDFDoc.fromPath(widget.file.path);
    String docText = await doc.text;

    textApi(docText);
    print(docText);
  }

  Future<void> textApi(String text) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("accessToken");
    final refreshToken = pref.getString("refreshToken");
    var response = await http.post(Uri.parse('${Api().api}/api/v1/text/'),
        headers: {
          'Authorization': 'Bearer $token',
          'Cookies': 'application/json'
        },
        body: {
          "text": text
        });

    final body = jsonDecode(response.body);
    print(body);
    if (response.statusCode == 200) {
      // setState(() {
      //   urls = body;
      // });
      setState(() {
        
        pdfAudio.add(body);
        url.addAll(
        [
          {
            'url': body,
            "isPlaying": false,
          }
        ],
      );
      });
    } else if (response.statusCode == 401) {
      var response = await http.post(
          Uri.parse("${Api().api}/api/v1/token/refresh/"),
          body: {"refresh": refreshToken});
      final body = jsonDecode(response.body);

      await pref.setString("accessToken", body['access']);

      token = body["access"];

      return textApi(scannedText);
    }
    setState(() {});
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
      if (isAssets) {
        Uint8List soundbytes =
            (await NetworkAssetBundle(Uri.parse(Api().api + "/media/" + pdfAudio[0][0]))
                    .load(Api().api +"/media/" + pdfAudio[0][0]))
                .buffer
                .asUint8List();
        audioPlayer = await audioCache.playBytes(soundbytes);
        setState(() {
          _playerState = PlayerState.PLAYING;
        });
      } else {
         Uint8List soundbytes =
            (await NetworkAssetBundle(Uri.parse(Api().api +"/media/" + pdfAudio[0][0]))
                    .load(Api().api +"/media/" + pdfAudio[0][0]))
                .buffer
                .asUint8List();
        final playerResult =
            await audioPlayer.playBytes(soundbytes);
        if (playerResult == 1) {
          setState(() {
            _playerState = PlayerState.PLAYING;
          });
        }
      }
    }
  }
}
