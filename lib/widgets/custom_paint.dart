//Copy this CustomPainter code to the Bottom of the File
// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * -0.002415459, size.height * 0.6366667);
    path_0.cubicTo(
        size.width * -0.002415459,
        size.height * 0.5808908,
        size.width * 0.01441338,
        size.height * 0.5331638,
        size.width * 0.03749831,
        size.height * 0.5234707);
    path_0.lineTo(size.width * 0.3104444, size.height * 0.4088667);
    path_0.cubicTo(
        size.width * 0.3400266,
        size.height * 0.3964460,
        size.width * 0.3671498,
        size.height * 0.4505885,
        size.width * 0.3671498,
        size.height * 0.5220598);
    path_0.lineTo(size.width * 0.3671498, size.height * 0.6471839);
    path_0.cubicTo(
        size.width * 0.3671498,
        size.height * 0.7106667,
        size.width * 0.3887778,
        size.height * 0.7621264,
        size.width * 0.4154589,
        size.height * 0.7621264);
    path_0.lineTo(size.width * 0.5869565, size.height * 0.7621264);
    path_0.cubicTo(
        size.width * 0.6136377,
        size.height * 0.7621264,
        size.width * 0.6352657,
        size.height * 0.7106667,
        size.width * 0.6352657,
        size.height * 0.6471839);
    path_0.lineTo(size.width * 0.6352657, size.height * 0.5225368);
    path_0.cubicTo(
        size.width * 0.6352657,
        size.height * 0.4509057,
        size.width * 0.6625024,
        size.height * 0.3967230,
        size.width * 0.6921329,
        size.height * 0.4094126);
    path_0.lineTo(size.width * 0.9578333, size.height * 0.5232057);
    path_0.cubicTo(
        size.width * 0.9808430,
        size.height * 0.5330598,
        size.width * 0.9975845,
        size.height * 0.5807011,
        size.width * 0.9975845,
        size.height * 0.6363276);
    path_0.lineTo(size.width * 0.9975845, size.height * 1.005747);
    path_0.lineTo(size.width * -0.002415459, size.height * 1.005747);
    path_0.lineTo(size.width * -0.002415459, size.height * 0.6366667);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Colors.white;
    canvas.drawShadow(
        path_0, const Color.fromRGBO(195, 200, 239, 0.21), 60, true);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

//Copy this CustomPainter code to the Bottom of the File
class BNBCustomPainter extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.4053667);
    path_0.cubicTo(
        0,
        size.height * 0.3155074,
        size.width * 0.04553686,
        size.height * 0.2386157,
        size.width * 0.1080020,
        size.height * 0.2229991);
    path_0.lineTo(size.width * 0.8465621, size.height * 0.03835898);
    path_0.cubicTo(size.width * 0.9266078, size.height * 0.01834787, size.width,
        size.height * 0.1055778, size.width, size.height * 0.2207259);
    path_0.lineTo(size.width, size.height * 0.6075000);
    path_0.lineTo(size.width, size.height * 0.8148148);
    path_0.cubicTo(size.width, size.height * 0.9170898, size.width * 0.9414771,
        size.height, size.width * 0.8692810, size.height);
    path_0.lineTo(0, size.height);
    path_0.lineTo(0, size.height * 0.4053667);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Colors.red.withOpacity(1.0);
    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

//Copy this CustomPainter code to the Bottom of the File
//Copy this CustomPainter code to the Bottom of the File
class BMBCustomPainter extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.4053667);
    path_0.cubicTo(
        0,
        size.height * 0.3155074,
        size.width * 0.04553686,
        size.height * 0.2386157,
        size.width * 0.1080020,
        size.height * 0.2229991);
    path_0.lineTo(size.width * 0.8465621, size.height * 0.03835898);
    path_0.cubicTo(size.width * 0.9266078, size.height * 0.01834787, size.width,
        size.height * 0.1055778, size.width, size.height * 0.2207259);
    path_0.lineTo(size.width, size.height * 0.6075000);
    path_0.lineTo(size.width, size.height * 0.8148148);
    path_0.cubicTo(size.width, size.height * 0.9170898, size.width * 0.9414771,
        size.height, size.width * 0.8692810, size.height);
    path_0.lineTo(0, size.height);
    path_0.lineTo(0, size.height * 0.4053667);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Colors.white.withOpacity(1.0);
    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
