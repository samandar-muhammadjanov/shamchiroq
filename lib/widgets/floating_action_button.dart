import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shamchiroq/models/style.dart';
import 'package:shamchiroq/screens/dashboard/camera/camera.dart';

class CameraActionButton extends StatelessWidget {
  const CameraActionButton({
    Key? key,
  }) : super(key: key);
  // final Function scanImage;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 45),
      child: ElevatedButton(
        onPressed: () async {
          await availableCameras().then(
            (value) => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Camera(
                  cameras: value,
                ),
              ),
            ),
          );
        },
        child: SvgPicture.asset("assets/images/camera.svg"),
        style: ElevatedButton.styleFrom(
            primary: kColor,
            shadowColor: const Color.fromRGBO(195, 200, 239, 0.21),
            elevation: 60,
            minimumSize: const Size(85, 85),
            maximumSize: const Size(85, 85),
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.white, width: 4),
                borderRadius: BorderRadius.circular(20))),
      ),
    );
  }
}
