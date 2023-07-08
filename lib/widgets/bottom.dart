// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shamchiroq/api/api.dart';
import 'package:shamchiroq/screens/dashboard/pdf.dart';
import 'package:shamchiroq/screens/dashboard/setting/setting.dart';
import 'package:shamchiroq/sizeconfige.dart';
import 'package:shamchiroq/widgets/custom_paint.dart';

class Bottom extends StatelessWidget {
  const Bottom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    return SizedBox(
      width: size.width,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(
                size.width,
                (size.width * 0.42028985507246375)
                    .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
            painter: RPSCustomPainter(),
          ),
          Positioned(
            width: size.width,
            bottom: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final file = await Api.pickFile();

                    if (file == null) return;
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return Pdf(
                        file: file,
                      );
                    }));
                  },
                  style: ButtonStyle(
                      overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.grey.withOpacity(0.4);
                          } //<-- SEE HERE
                          return null; // Defer to the widget's default.
                        },
                      ),
                      shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.elliptical(120, 40),
                                  topRight: Radius.elliptical(30, 20)))),
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      minimumSize:
                          MaterialStateProperty.all( Size(wi(138), he(97)))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: SvgPicture.asset("assets/images/pdf.svg"),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const Setting();
                    }));
                  },
                  style: ButtonStyle(
                      overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.grey.withOpacity(0.4);
                          } //<-- SEE HERE
                          return null; // Defer to the widget's default.
                        },
                      ),
                      shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.elliptical(30, 20),
                                  topRight: Radius.elliptical(120, 40)))),
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      minimumSize:
                          MaterialStateProperty.all(Size(wi(138), he(97)))),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 25.0),
                    child: SvgPicture.asset("assets/images/setting.svg"),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
