// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shamchiroq/models/style.dart';

class PaymentNotification extends StatelessWidget {
  const PaymentNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar,
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("Har doim sevimli kitoblaringiz bilan bo’ling!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 24,
                        fontFamily: kmont,
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
                        fontFamily: kmont,
                        fontWeight: FontWeight.w500)),
              ),
              Image.asset("assets/images/premium..png"),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                    "Tekshirib ko’rish muddati tugadi foydalanishda davom etish uchun to’lovni amalga oshiring",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 24,
                        fontFamily: kFont,
                        fontWeight: FontWeight.bold)),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Obuna uchun to’lov"),
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    minimumSize: Size(244, 68),
                    textStyle: TextStyle(fontSize: 18, fontFamily: kFont)),
              ),
              Spacer()
            ],
          ),
        ));
  }
}
