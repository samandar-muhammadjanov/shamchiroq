// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shamchiroq/models/style.dart';
import 'package:shamchiroq/screens/dashboard/dashboard.dart';
import 'package:shamchiroq/screens/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  // void checkLog() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String? val = pref.getString('accessToken');
  //   if (val != null) {
  //     Future.microtask(() => Navigator.of(context).pushAndRemoveUntil(
  //         MaterialPageRoute(builder: (context) => Dashboard()),
  //         (route) => false));
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // checkLog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(246, 250, 255, 1),
        appBar: appBar,
        body: Column(
          children: [
            Image.asset(
              "assets/images/intro_image.png",
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("Har doim sevimli kitoblaringiz bilan bo’ling!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 24,
                      fontFamily: GoogleFonts.montserrat().fontFamily,
                      fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                  "Qog’oz hamda elektron kitoblarni audio ko’rinishda biz bilan qulay tinglang! ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromRGBO(132, 132, 132, 1),
                      fontSize: 14,
                      fontFamily: GoogleFonts.montserrat().fontFamily,
                      fontWeight: FontWeight.w500)),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) {
                      return Login();
                    },
                  ),
                );
              },
              child: Text("Boshlash"),
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  minimumSize: Size(244, 68),
                  textStyle: TextStyle(fontSize: 18, fontFamily: kFont)),
            ),
            Spacer()
          ],
        ));
  }
}
