import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shamchiroq/models/style.dart';
import 'package:shamchiroq/screens/dashboard/payment/payment_screen.dart';

class Subscription extends StatelessWidget {
  const Subscription({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Obunaning tugash vaqti",
          style: TextStyle(
              color: const Color.fromRGBO(200, 212, 227, 1),
              fontSize: 20,
              fontFamily: kRoboto),
        ),
       const SizedBox(
          height: 20,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            leading: SvgPicture.asset("assets/images/date.svg"),
            title: Text("2021.07.14 20:26",
                style: TextStyle(
                    color:const Color.fromRGBO(133, 133, 133, 1),
                    fontFamily: kRoboto,
                    fontSize: 15)),
            trailing: ElevatedButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const PaymentScreen())),
              style: ElevatedButton.styleFrom(
                minimumSize:const Size(48,48),
                shadowColor:const Color.fromRGBO(217, 222, 250, 1),
                primary: kColor
              ),
              child:  SvgPicture.asset("assets/images/reply.svg"),
              
            ),
          ),
        )
      ],
    );
  }
}
