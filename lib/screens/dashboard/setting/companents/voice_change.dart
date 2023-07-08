import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shamchiroq/models/style.dart';

class Voice extends StatefulWidget {
  Voice({Key? key, required this.selectedVoice, required this.voices})
      : super(key: key);
  String selectedVoice;
  List<String> voices;
  @override
  State<Voice> createState() => _VoiceState();
}

class _VoiceState extends State<Voice> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal:8),
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromRGBO(209, 209, 209, 1)),
          borderRadius: BorderRadius.circular(4)),
      child: DropdownButton<String>(
          elevation: 1,
          itemHeight: 50,
          isExpanded: true,
          underline: const SizedBox(),
          // decoration: InputDecoration(
          //     enabledBorder: OutlineInputBorder(
          //         borderSide:
          //             const BorderSide(color: Color.fromRGBO(209, 209, 209, 1)),
          //         borderRadius: BorderRadius.circular(4)),
          //     focusedBorder: OutlineInputBorder(
          //         borderSide:
          //             const BorderSide(color: Color.fromRGBO(209, 209, 209, 1)),
          //         borderRadius: BorderRadius.circular(4))),
          icon: SvgPicture.asset('assets/images/drop.svg'),
          // icon: const SizedBox(),
          value: widget.selectedVoice,
          items: widget.voices
              .map(
                (e) => DropdownMenuItem<String>(
                  value: e,
                  child: Text(
                    e,
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: kRoboto,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              )
              .toList(),
          onChanged: (item) => setState(() => widget.selectedVoice = item!)),
    );
  }
}
