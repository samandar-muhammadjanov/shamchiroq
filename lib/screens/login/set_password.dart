// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:shamchiroq/api/api.dart';
import 'package:shamchiroq/models/style.dart';

class Password extends StatefulWidget {
  Password({Key? key, required this.phoneNumber}) : super(key: key);
  final String phoneNumber;

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  final TextEditingController controller = TextEditingController();

  final TextEditingController repeat = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
            children: [
              Spacer(),
              Text(
                "Ro’yxatdan o’tish",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kColor,
                  fontSize: 26,
                  fontFamily: kmont,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Spacer(),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0, top: 10),
                      child: Text(
                        "Parol kiriting",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontFamily: kRoboto),
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Ushbu maydon bo’sh bo’lmasligi kerak!';
                        } else if (value.length < 8) {
                          return "Ushbu maydon 8 ta belgidan kam bo`lmasligi lozim";
                        }
                        return null;
                      },
                      obscureText: true,
                      controller: controller,
                      cursorColor: kColor,
                      inputFormatters: [LengthLimitingTextInputFormatter(12)],
                      onChanged: (value) =>
                          setState(() => formKey.currentState!.validate()),
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: kRoboto,
                          fontWeight: FontWeight.bold,
                          wordSpacing: 10),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(209, 209, 209, 1),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: kColor,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0, top: 10),
                      child: Text(
                        "Parolni qayta kiriting",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontFamily: kRoboto),
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Ushbu maydon bo’sh bo’lmasligi kerak!';
                        } else if (value.length < 8) {
                          return "Ushbu maydon 8 ta belgidan kam bo`lmasligi lozim";
                        } else if (controller.text != repeat.text) {
                          return "Ushbu maydon 1-maydon bilan mos emas!";
                        }
                        return null;
                      },
                      obscureText: true,
                      controller: repeat,
                      cursorColor: kColor,
                      inputFormatters: [LengthLimitingTextInputFormatter(12)],
                      onChanged: (value) =>
                          setState(() => formKey.currentState!.validate()),
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: kRoboto,
                          fontWeight: FontWeight.bold,
                          wordSpacing: 10),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(209, 209, 209, 1),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: kColor,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(),
                        ElevatedButton(
                            onPressed: () {
                              // Api().active(
                              //     context, controller, widget.phoneNumber);
                              if (formKey.currentState!.validate()) {
                                Api().password(
                                    controller, widget.phoneNumber, context);
                              }
                            },
                            child: Text("Kiritish"),
                            style: ElevatedButton.styleFrom(
                                primary: kColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                minimumSize: Size(160, 60),
                                textStyle:
                                    TextStyle(fontSize: 18, fontFamily: kFont)))
                      ],
                    ),
                  ],
                ),
              ),
              Spacer(),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
