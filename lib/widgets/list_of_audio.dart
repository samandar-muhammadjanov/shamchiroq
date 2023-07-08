// import 'dart:typed_data';

// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:hive/hive.dart';
// import 'package:shamchiroq/api/api.dart';
// import 'package:shamchiroq/models/style.dart';

// class ListOfAudios extends StatefulWidget {
//   const ListOfAudios({Key? key}) : super(key: key);

//   @override
//   State<ListOfAudios> createState() => _ListOfAudiosState();
// }

// class _ListOfAudiosState extends State<ListOfAudios> {
//   List<String> list = [];
//   bool isPlaying = false;

//   final audioPlayer = AudioPlayer();
//   String currentSong = "";

//     List box = Hive.box("url").get(0) ?? [];
//   @override
//   void initState() {
//     super.initState();
//     setState(() {});
//     print(box.length);
//   }

//   @override
//   void dispose() {
//     audioPlayer.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     print(Hive.box("url").get(0));
//     if (Hive.box("url").isEmpty) {
//     print("hello");
//       return Center(
//         child: Text(
//           "So’nggi tinglangan audiolar mavjud\nemas",
//           textAlign: TextAlign.center,
//           style: TextStyle(
//               // color: const Color.fromRGBO(214, 214, 214, 1),
//               fontFamily: kRoboto,
//               fontSize: 18),
//         ),
//       );
//     }
//     return ListView.builder(
//       physics: const BouncingScrollPhysics(),
//       itemCount: box.length > 10 ? 10 : box.length,
//       itemBuilder: (context, index) {
//         String text = box[index]["url"][0].toString();
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//           child: Container(
//             height: 85,
//             alignment: Alignment.center,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: ListTile(
//               title: Text(
//                 "${text.substring(10, 14)}.${text.substring(8, 10)}.${text.substring(6, 8)} ${text.substring(0, 2)}:${text.substring(2, 4)}",
//                 style: TextStyle(
//                     fontSize: 15,
//                     fontFamily: kRoboto,
//                     color: const Color.fromARGB(255, 107, 107, 107)),
//               ),
//               trailing: GestureDetector(
//                 onTap: () async {
//                   Hive.box("url").clear();
//                   audioPlayer.onPlayerStateChanged.listen((state) {
//                     print(state);
//                     print(index);
//                     if (mounted) {
//                       setState(() {
//                         box[index]["isPlaying"] =
//                             state == PlayerState.COMPLETED;
//                       });
//                     }
//                   });
//                   if (box[index]["isPlaying"]) {
//                     audioPlayer.stop();
//                   } else {
//                     Uint8List soundbytes = (await NetworkAssetBundle(Uri.parse(
//                                 Api().api + "/media/" + box[index]["url"][0]))
//                             .load(Api().api + "/media/" + box[index]["url"][0]))
//                         .buffer
//                         .asUint8List();
//                     await audioPlayer.playBytes(soundbytes);
//                   }
//                 },
//                 child: Container(
//                   alignment: Alignment.center,
//                   width: 55,
//                   height: 55,
//                   decoration: const BoxDecoration(
//                       color: Color.fromRGBO(94, 114, 228, 0.13),
//                       shape: BoxShape.circle),
//                   child: SvgPicture.asset(box[index]["isPlaying"] == true
//                       ? "assets/images/stop-col.svg"
//                       : "assets/images/play.svg"),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
