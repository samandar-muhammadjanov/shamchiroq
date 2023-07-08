// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shamchiroq/models/style.dart';
import 'package:shamchiroq/screens/dashboard/payment/confirm_payment.dart';

class PayCard extends StatefulWidget {
  const PayCard({Key? key}) : super(key: key);

  @override
  State<PayCard> createState() => _PayCardState();
}

class _PayCardState extends State<PayCard> {
  var maskFormatter = MaskTextInputFormatter(
      mask: '#### #### #### ####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  @override
  Widget build(BuildContext context) {
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
                  "Karta raqamini kiriting",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontFamily: GoogleFonts.roboto().fontFamily),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 10),
                height: 70,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(color: Color.fromRGBO(209, 209, 209, 1)),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: TextFormField(
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: kRoboto,
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [maskFormatter],
                    decoration: InputDecoration(
                        hintText: "–––– –––– –––– ––––",
                        hintStyle: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(209, 209, 209, 1)),
                        fillColor: Colors.white,
                        border:
                            UnderlineInputBorder(borderSide: BorderSide.none)),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text("Orqaga"),
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(200, 212, 227, 1),
                          shadowColor: Color.fromRGBO(255, 255, 255, 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          minimumSize: Size(142, 60),
                          textStyle:
                              TextStyle(fontSize: 18, fontFamily: kFont))),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {
                          return ConfirmPayment();
                        }));
                      },
                      child: Text("To’lash"),
                      style: ElevatedButton.styleFrom(
                          primary: kColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          shadowColor: Color.fromRGBO(255, 255, 255, 1),
                          minimumSize: Size(160, 60),
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
