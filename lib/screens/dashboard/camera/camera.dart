// ignore_for_file: prefer_function_declarations_over_variables

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import 'package:hive/hive.dart';
import 'package:shamchiroq/api/api.dart';
import 'package:shamchiroq/models/style.dart';
import 'package:shamchiroq/sizeconfige.dart';
import 'package:shamchiroq/widgets/custom_paint.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Camera extends StatefulWidget {
  const Camera({Key? key, required this.cameras}) : super(key: key);

  final List<CameraDescription>? cameras;
  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  late CameraController controller;
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  List urls = Hive.box("url").get(0) ?? [];
  String? imagePath;
  String scannedText = "";
  String playerAssets = "assets/images/play_outlined.svg";
  String audio = "";

  @override
  void initState() {
    super.initState();
    print(urls.length);
    controller = CameraController(
      widget.cameras![0],
      ResolutionPreset.max,
    );
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});

    });

    audioPlayer.onPlayerStateChanged.listen((state) {
      if (!mounted) {
        setState(() {
          isPlaying = state == PlayerState.PLAYING;
        });
      }
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () async {
        final image = await controller.takePicture();
        setState(() {
          imagePath = image.path;
          getRecognisedText(image);
        });
      },
      child: Scaffold(
        body: Stack(
          children: [
            if (!controller.value.isInitialized)
              const SizedBox(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            else
              camera(size),
            appBarWithAction(context),
            Positioned(
              bottom: 0,
              left: 0,
              child: SizedBox(
                width: size.width,
                child: Stack(
                  children: [
                    CustomPaint(
                      size: Size(size.width,
                          (size.width * 0.42028985507246375).toDouble()),
                      painter: RPSCustomPainter(),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 23.0,
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
                            Hive.box("url").put(0, urls);
                            print(urls);
                            if (imagePath!.isNotEmpty) {
                              if (isPlaying) {
                                audioPlayer.resume();
                              } else {
                                for (var i = 0; i < urls.length; i++) {
                                  Uint8List soundbytes =
                                      (await NetworkAssetBundle(Uri.parse(
                                                  "${Api().api}/media/$audio"))
                                              .load(
                                                  "${Api().api}/media/$audio"))
                                          .buffer
                                          .asUint8List();
                                  audioPlayer.playBytes(soundbytes);
                                }
                              }
                            } else {
                              null;
                            }
                          },
                          child: SvgPicture.asset(isPlaying
                              ? "assets/images/stop.svg"
                              : playerAssets),
                          style: ElevatedButton.styleFrom(
                              primary: kColor,
                              shadowColor: Colors.transparent,
                              elevation: 0,
                              minimumSize: const Size(85, 85),
                              maximumSize: const Size(85, 85),
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      color: Colors.white, width: 4),
                                  borderRadius: BorderRadius.circular(20))),
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
                            onPressed: () {
                              print(audio);
                            },
                            child: SvgPicture.asset("assets/images/p_left.svg"),
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
                                            topLeft: Radius.elliptical(120, 40),
                                            topRight:
                                                Radius.elliptical(30, 20)))),
                                elevation: MaterialStateProperty.all(0),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                minimumSize: MaterialStateProperty.all(
                                    Size(wi(138), he(97)))),
                          ),
                          ElevatedButton(
                              onPressed: () {},
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

// methods and functions for camera and text recognation and for play audio

  SizedBox camera(Size size) {
    return SizedBox(
        height: size.height,
        width: size.width,
        child: imagePath == null
            ? CameraPreview(controller)
            : scannedText.isNotEmpty
                ? Image.file(
                    File(imagePath!),
                    width: size.width,
                    fit: BoxFit.cover,
                    height: size.height,
                  )
                : const Center(child: CircularProgressIndicator()));
  }

  void getRecognisedText(XFile image) async {
    String text =
        await FlutterTesseractOcr.extractText(image.path, language: 'uzb');
    setState(() {
      scannedText = text;
    });
    textApi(scannedText);
    setState(() {});
  }

  Future<void> textApi(String text) async {
    final url = Api().api;
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("accessToken");
    final refreshToken = pref.getString("refreshToken");
    var response = await http.post(Uri.parse('$url/api/v1/text/'), headers: {
      'Authorization': 'Bearer $token',
      'Cookies': 'application/json'
    }, body: {
      "text": text
    });
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(
        () {
          audio = body[0];
          urls.addAll(
            [
              {
                'url': body,
                "isPlaying": false,
              }
            ],
          );
        },
      );
   
      await pref.setString("url", body.toString());
    } else if (response.statusCode == 401) {
      var response = await http.post(Uri.parse("$url/api/v1/token/refresh/"),
          body: {"refresh": refreshToken});
      final body = jsonDecode(response.body);
      await pref.setString("accessToken", body['access']);
      token = body["access"];
      return textApi(scannedText);
    } else {
      return;
    }
  }
}
