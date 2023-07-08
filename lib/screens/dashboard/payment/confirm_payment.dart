// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shamchiroq/models/style.dart';
import 'package:shamchiroq/screens/dashboard/dashboard.dart';

class ConfirmPayment extends StatefulWidget {
  const ConfirmPayment({Key? key}) : super(key: key);

  @override
  State<ConfirmPayment> createState() => _ConfirmPaymentState();
}

class _ConfirmPaymentState extends State<ConfirmPayment> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String confirmText = 'Tasdiqlash kodini kiriting';
  Color confirmColor = Colors.black;
  String code = "000000";
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
              Center(
                child: Text(
                  "To’lovni tasdiqlash",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kColor,
                    fontSize: 26,
                    fontFamily: kmont,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0, top: 10),
                child: Text(
                  confirmText,
                  style: TextStyle(
                      color: confirmColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontFamily: kRoboto),
                ),
              ),
              Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.only(left: 30, right: 10),
                  height: 70,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Color.fromRGBO(209, 209, 209, 1)),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isNotEmpty && value.length < 6) {
                        return null;
                      } else if (value != code) {
                        setState(() {
                          confirmText = "Tasdiqlash kodi xato kiritildi";
                          confirmColor = Colors.red;
                        });
                      } else if (value == code) {
                        setState(() {
                          confirmText = "Tasdiqlash kodini kiriting";
                          confirmColor = Colors.black;
                        });
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => Dashboard()),
                            (route) => false);
                      } else {
                        return;
                      }
                    },
                    style: TextStyle(
                        fontSize: 20, fontFamily: kRoboto, letterSpacing: 30),
                    keyboardType: TextInputType.number,
                    inputFormatters: [LengthLimitingTextInputFormatter(6)],
                    decoration: InputDecoration(
                        hintText: "––––––",
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
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          shadowColor: Color.fromRGBO(255, 255, 255, 1),
                          minimumSize: Size(142, 60),
                          textStyle:
                              TextStyle(fontSize: 18, fontFamily: kFont))),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          return;
                        }
                      },
                      child: Text("Tasdiqlash"),
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
