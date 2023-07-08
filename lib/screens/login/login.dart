import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shamchiroq/api/api.dart';
import 'package:shamchiroq/models/style.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shamchiroq/screens/login/registration.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController password = TextEditingController();

  var maskFormatter = MaskTextInputFormatter(
      mask: '## ### ## ##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var isInsets = MediaQuery.of(context).viewInsets == 0;
    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.only(
          top: 20.0,
          left: 20,
          right: 20,
        ),
        child: Center(
          child: Column(
            children: [
              const Spacer(),
              Text(
                "Tizimga kirish",
                style: TextStyle(
                  color: kColor,
                  fontSize: 26,
                  fontFamily: GoogleFonts.montserrat().fontFamily,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
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
                        controller: phoneNumber,
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0, top: 7),
                        child: Text(
                          "Parolni kiriting",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              fontFamily: GoogleFonts.roboto().fontFamily),
                        ),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Ushbu maydon bo’sh bo’lmasligi kerak!';
                          }
                          return null;
                        },
                        obscureText: true,
                        controller: password,
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
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(),
                          ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  Api().login(phoneNumber, password, context);
                                }
                              },
                              child: const Text("Kirish"),
                              style: ElevatedButton.styleFrom(
                                  primary: Theme.of(context).primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  minimumSize: const Size(180, 60),
                                  textStyle: TextStyle(
                                      fontSize: 18, fontFamily: kFont)))
                        ],
                      ),
                    ],
                  )),
              const Spacer(),
              isInsets
                  ? const SizedBox()
                  : TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                          return const Registration();
                        }));
                      },
                      child: Text(
                        "Ro’yxatdan o’tish",
                        style: TextStyle(
                          color: kColor,
                          fontSize: 20,
                          fontFamily: GoogleFonts.montserrat().fontFamily,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
