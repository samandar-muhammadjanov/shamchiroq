import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shamchiroq/api/api.dart';
import 'package:shamchiroq/models/style.dart';
import 'package:shamchiroq/screens/dashboard/setting/companents/setting_ocr.dart';
import 'package:shamchiroq/screens/dashboard/setting/companents/voice_change.dart';

class SettingMGMT extends StatefulWidget {
  SettingMGMT({
    Key? key,
    required this.selectedVoice,
    required this.voices,
    required this.isChanged,
    required this.newPhone,
    required this.controller,
    required this.maskFormatter
  }) : super(key: key);
  String selectedVoice;
  List<String> voices;
  bool isChanged;
  String newPhone;
  TextEditingController controller;
  MaskTextInputFormatter maskFormatter;
  @override
  State<SettingMGMT> createState() => _SettingMGMTState();
}

class _SettingMGMTState extends State<SettingMGMT> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 40),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset("assets/images/voice.svg"),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Voice(
                    selectedVoice: widget.selectedVoice, voices: widget.voices),
              )
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset("assets/images/phone.svg"),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          String newphone =value.split("+998").join().split("(").join().split(")").join().split("-").join();
                          if (widget.controller.text.length == 17) {
                            setState(() {
                              widget.isChanged = true;
                              widget.controller.text = value;
                              widget.newPhone = newphone;
                            });

                            Api().changePhoneNumber(context, widget.newPhone);
                          }
                        },
                        inputFormatters: [widget.maskFormatter],
                        keyboardType: TextInputType.phone,
                        controller: widget.controller,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor:
                                const Color.fromRGBO(217, 222, 250, 0.38),
                            suffixIcon: Container(
                              alignment: Alignment.center,
                              width: 20,
                              height: 20,
                              child: widget.isChanged
                                  ? SvgPicture.asset("assets/images/x.svg")
                                  : SvgPicture.asset(
                                      "assets/images/edit.svg",
                                    ),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none)),
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: kRoboto,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          if (widget.isChanged) SettingOcr(isChanged: widget.isChanged, newPhone: widget.newPhone),
        ],
      ),
    );
  }
}
