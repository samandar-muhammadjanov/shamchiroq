// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:shamchiroq/api/api.dart';
import 'package:shamchiroq/models/provider.dart';
import 'package:shamchiroq/models/style.dart';
import 'package:shamchiroq/widgets/bottom.dart';
import 'package:shamchiroq/widgets/floating_Action_button.dart';
import 'package:shamchiroq/widgets/list_of_audio.dart';
import 'package:shamchiroq/widgets/new_list.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  File? image;

  bool isInitailazed = false;
  List box = Hive.box("url").get(0) ?? [];

  @override
  void initState() {
    super.initState();
    final data = Provider.of<Data>(context, listen: false);
    data.fetchUserData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
      backgroundColor: kbackground,
      appBar: appBar,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                child: Text(
                  "So’nggi tinglangan audiolar",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: kRoboto,
                      color: Color.fromRGBO(155, 158, 168, 1)),
                ),
              ),
              box.isEmpty
                  ? Center(
                      child: Text(
                        "So’nggi tinglangan audiolar mavjud\nemas",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: const Color.fromRGBO(214, 214, 214, 1),
                            fontFamily: kRoboto,
                            fontSize: 18),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: box.length,
                        itemBuilder: (ctx, index) {
                          String text = box[index]["url"][0].toString();
                          return AudioList(
                            url: Api().api + "/media/${box[index]["url"][0]}",
                            isAsset: false,
                            text:
                                "${text.substring(10, 14)}.${text.substring(8, 10)}.${text.substring(6, 8)} ${text.substring(0, 2)}:${text.substring(2, 4)}",
                          );
                        },
                      ),
                    ),
                    SizedBox()
            ],
          ),
          Positioned(bottom: 0, left: 0, child: Bottom())
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CameraActionButton(),
    );
  }
}
