import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shamchiroq/models/user_data.dart';
import '../api/api.dart';

class Data extends ChangeNotifier {
  UserData? dataModel;
  List<String>? audio;
  fetchUserData() async {
    dataModel = await Api().userData();
    notifyListeners();
  }

  fetchAudio() async {
    // audio = await Api().text
  }
}
