import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shamchiroq/screens/dashboard/dashboard.dart';

const kColor = Color.fromRGBO(94, 114, 228, 1);
final kFont = GoogleFonts.lato().fontFamily;
final kRoboto = GoogleFonts.roboto().fontFamily;
final kmont = GoogleFonts.montserrat().fontFamily;
const kbackground = Color.fromRGBO(246, 250, 255, 1);

final appBar = AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0,
  toolbarHeight: 90,
  automaticallyImplyLeading: false,
  title: Row(
    children: [
      SvgPicture.asset("assets/images/logo.svg"),
      const SizedBox(
        width: 20,
      ),
      Text("Shamchiroq",
          style: TextStyle(
              color: kColor,
              fontFamily: kFont,
              fontSize: 25,
              fontWeight: FontWeight.bold)),
    ],
  ),
);

AppBar appBarWithAction(context) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Colors.transparent,
    elevation: 0,
    toolbarHeight: 90,
    title: Row(
      children: [
        SvgPicture.asset("assets/images/logo.svg"),
        const SizedBox(
          width: 20,
        ),
        Text("Shamchiroq",
            style: TextStyle(
                color: kColor,
                fontFamily: kFont,
                fontSize: 25,
                fontWeight: FontWeight.bold)),
      ],
    ),
    actions: [
      ElevatedButton(
          onPressed: () => Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) {
                return const Dashboard();
              })),
          style: ButtonStyle(
              overlayColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.grey.withOpacity(0.4);
                  } //<-- SEE HERE
                  return null; // Defer to the widget's default.
                },
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60),
                ),
              ),
              elevation: MaterialStateProperty.all(0),
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              minimumSize: MaterialStateProperty.all(const Size(90, 30))),
          child: SvgPicture.asset("assets/images/home.svg")),
    ],
  );
}
