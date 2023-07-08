// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shamchiroq/api/api.dart';
import 'package:shamchiroq/models/style.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shamchiroq/screens/dashboard/dashboard.dart';
import 'package:shamchiroq/screens/login/registration.dart';

class Activate extends StatefulWidget {
  const Activate({Key? key, required this.phoneNumber}) : super(key: key);
  final String phoneNumber;
  @override
  State<Activate> createState() => _ActivateState();
}

class _ActivateState extends State<Activate> {
  final TextEditingController controller = TextEditingController();
  var maskFormatter = MaskTextInputFormatter(
      mask: '# # # # # #',
      filter: {"#": RegExp(r'[0-6]')},
      type: MaskAutoCompletionType.lazy);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String confirmText = 'Tasdiqlash kodini kiriting';
  Color confirmColor = Colors.black;
  bool isFieldEntered = false;
  bool isCodeCorrect = true;
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
                "Mobil raqamni tasdiqlash",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kColor,
                  fontSize: 26,
                  fontFamily: GoogleFonts.montserrat().fontFamily,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Spacer(),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0, top: 10),
                      child: Text(
                        confirmText,
                        style: TextStyle(
                            fontSize: 18,
                            color: confirmColor,
                            fontWeight: FontWeight.w500,
                            fontFamily: GoogleFonts.roboto().fontFamily),
                      ),
                    ),
                    TextFormField(
                      textAlign: TextAlign.center,
                      validator: (value) {
                        if (value!.length == 6) {
                          setState(() => isFieldEntered = true);
                        } else if (value.length < 6 && value.length> 0){
                          setState(() => isFieldEntered = false);
                        } else if (value.isEmpty) {
                          return "Ushbu maydon bo`sh bo`lmasligi kerak!";
                        }
                        return null;
                      },
                      onChanged: (value) =>
                          setState(() => _formKey.currentState!.validate()),
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: kRoboto,
                          letterSpacing: 30,
                          fontWeight: FontWeight.bold),
                      controller: controller,
                      keyboardType: TextInputType.number,
                      inputFormatters: [LengthLimitingTextInputFormatter(6)],
                      decoration: InputDecoration(
                        hintText: "––––––",
                        hintStyle: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(209, 209, 209, 1)),
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
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => Registration()));
                            },
                            child: Text("Orqaga"),
                            style: ElevatedButton.styleFrom(
                                shadowColor: Color.fromRGBO(255, 255, 255, 1),
                                elevation: 10,
                                primary: isFieldEntered
                                    ? Color.fromRGBO(200, 212, 227, 1)
                                    : kColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                minimumSize: Size(142, 60),
                                textStyle: TextStyle(
                                    fontSize: 18, fontFamily: kFont))),
                        ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {

                                  Api().active(context, controller,
                                      widget.phoneNumber, isCodeCorrect);

                              }
                            },
                            child: Text("Kirish"),
                            style: ElevatedButton.styleFrom(
                                shadowColor: Color.fromRGBO(255, 255, 255, 1),
                                elevation: 10,
                                primary: !isFieldEntered
                                    ? Color.fromRGBO(200, 212, 227, 1)
                                    : kColor,
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
              SizedBox(
                height: 50,
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
