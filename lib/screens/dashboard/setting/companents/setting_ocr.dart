import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:shamchiroq/api/api.dart';
import 'package:shamchiroq/models/provider.dart';
import 'package:shamchiroq/models/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingOcr extends StatefulWidget {
  SettingOcr({Key? key, required this.isChanged, required this.newPhone}) : super(key: key);
  bool isChanged;
  String newPhone;
  @override
  State<SettingOcr> createState() => _SettingOcrState();
}

class _SettingOcrState extends State<SettingOcr> {
  final TextEditingController controller = TextEditingController();
  var maskFormatter = MaskTextInputFormatter(
      mask: '######',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          "Tasdiqlash kodini kiriting",
          textAlign: TextAlign.left,
          style: TextStyle(
              color: const Color.fromRGBO(200, 212, 227, 1),
              fontSize: 20,
              fontFamily: kRoboto),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Form(
              child: Expanded(
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromRGBO(194, 194, 194, 1),
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    controller: controller,
                    inputFormatters: [maskFormatter],
                    style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 9,
                        fontFamily: kRoboto,
                        fontWeight: FontWeight.bold),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "––––––",
                        hintStyle: const TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(194, 194, 194, 1)),
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        )),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ElevatedButton(
                  onPressed: () async {
                    final data = Provider.of<Data>(context, listen: false);
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    var isMatched = pref.getBool("isMatched");
                    Api().changePhoneNumberOtp(widget.newPhone, controller.text);
                    if (isMatched == true) {
                      data.fetchUserData();
                      setState(() {
                        widget.isChanged = false;
                      });
                    }
                  },
                  child: const Text("Tasdiqlash"),
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      minimumSize: const Size(120, 50),
                      textStyle: TextStyle(fontSize: 16, fontFamily: kFont))),
            )
          ],
        )
      ],
    );
  }
}
