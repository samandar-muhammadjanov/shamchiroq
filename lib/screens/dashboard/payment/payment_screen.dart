// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shamchiroq/models/style.dart';
import 'package:shamchiroq/screens/dashboard/payment/pay_card.dart';
import 'package:shamchiroq/sizeconfige.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymetnScreenState();
}

class _PaymetnScreenState extends State<PaymentScreen> {
  List<Map<String, dynamic>> price = [
    {
      "date": "1 oylik",
      "price": 10000,
      "color": Color.fromRGBO(209, 209, 209, 1),
      "colorO": Color.fromRGBO(209, 209, 209, 0),
    },
    {
      "date": "6 oylik",
      "price": 50000,
      "color": Color.fromRGBO(98, 250, 126, 1),
      "colorO": Color.fromRGBO(98, 250, 126, 0),
    },
    {
      "date": "1 yillik",
      "price": 100000,
      "color": Color.fromRGBO(253, 211, 104, 1),
      "colorO": Color.fromRGBO(253, 211, 104, 0),
    }
  ];
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: EdgeInsets.only(
          top: 20.0,
          left: 20,
          right: 20,
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(),
              Text(
                "Dastur obunasi uchun to’lov",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kColor,
                  fontSize: 26,
                  fontFamily: kmont,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0, top: 10),
                child: Text(
                  "Obuna turini tanlang",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontFamily: GoogleFonts.roboto().fontFamily),
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    cards(() => setState(() => selectedIndex = 0), price[0],
                        selectedIndex, 0),
                    cards(() => setState(() => selectedIndex = 1), price[1],
                        selectedIndex, 1),
                    cards(() => setState(() => selectedIndex = 2), price[2],
                        selectedIndex, 2)
                  ],
                ),
              ),
              Spacer(),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text("Bekor qilish"),
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(200, 212, 227, 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          minimumSize: Size(142, 60),
                          shadowColor: Color.fromRGBO(255, 255, 255, 1),
                          textStyle:
                              TextStyle(fontSize: 18, fontFamily: kFont))),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return PayCard();
                        }));
                      },
                      child: Text("Davom etish"),
                      style: ElevatedButton.styleFrom(
                          primary: kColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          minimumSize: Size(160, 60),
                          shadowColor: Color.fromRGBO(255, 255, 255, 1),
                          textStyle:
                              TextStyle(fontSize: 18, fontFamily: kFont)))
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget cards(onTap, box, selected, index) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 3.0),
    child: Stack(
      children: [
        Container(
            height: he(155),
            width: wi(100),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [box["color"], box["colorO"]]),
                borderRadius: BorderRadius.circular(10))),
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onTap,
            child: Container(
              height: he(150),
              padding: const EdgeInsets.symmetric(vertical: 10),
              width: wi(95),
              decoration: BoxDecoration(
                  color: selected == index
                      ? Color.fromRGBO(236, 240, 253, 1)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Text(
                    box['date'],
                    style: TextStyle(fontSize: 18, fontFamily: kFont),
                  ),
                  Spacer(),
                  Text(
                    box['price'].toString(),
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: kFont,
                        fontWeight: FontWeight.w900),
                  ),
                  Text(
                    'so’m',
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: kFont,
                        fontWeight: FontWeight.w900),
                  ),
                  // Spacer(),
                ],
              ),
            ),
          ),
        )
      ],
    ),
  );
}
