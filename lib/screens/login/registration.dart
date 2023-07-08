// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shamchiroq/api/api.dart';
import 'package:shamchiroq/models/style.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shamchiroq/screens/login/activate.dart';
import 'package:shamchiroq/screens/login/login.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  var maskFormatter = MaskTextInputFormatter(
      mask: '## ### ## ##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              Spacer(),
              Text(
                "Ro’yxatdan o’tish",
                style: TextStyle(
                  color: kColor,
                  fontSize: 26,
                  fontFamily: GoogleFonts.montserrat().fontFamily,
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
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Text(
                          "Mobil raqamingizni kiriting",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              fontFamily: GoogleFonts.roboto().fontFamily),
                        ),
                      ),
                      TextFormField(
                        autocorrect: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Ushbu maydon bo’sh bo’lmasligi kerak!';
                          }
                          return null;
                        },
                        controller: controller,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: kRoboto,
                          fontWeight: FontWeight.bold,
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [maskFormatter],
                        cursorHeight: 20,
                        cursorColor: kColor,
                        onChanged: (value) =>
                            setState(() => formKey.currentState!.validate()),
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding:
                                const EdgeInsets.only(left: 12.0, right: 5),
                            child: SvgPicture.asset(
                              "assets/images/uz2.svg",
                              width: 98,
                            ),
                          ),
                          hintText: "–– ––– –– ––",
                          hintStyle: const TextStyle(
                              fontSize: 18,
                              color: Color.fromRGBO(209, 209, 209, 1)),
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromRGBO(209, 209, 209, 1),
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
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: kColor,
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
                                if(formKey.currentState!.validate()){
                                   Api().register(controller, context);
                                }
                              },
                              child: Text("Jo’natish"),
                              style: ElevatedButton.styleFrom(
                                  primary: Theme.of(context).primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  minimumSize: Size(180, 60),
                                  textStyle: TextStyle(
                                      fontSize: 18, fontFamily: kFont)))
                        ],
                      ),
                    ],
                  )),
              Spacer(),
              SizedBox(
                height: 50,
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context) {
                    return Login();
                  }));
                },
                child: Text(
                  "Tizimga kirish",
                  style: TextStyle(
                    color: kColor,
                    fontSize: 20,
                    fontFamily: GoogleFonts.montserrat().fontFamily,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
