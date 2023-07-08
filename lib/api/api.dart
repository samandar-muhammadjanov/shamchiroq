import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:provider/provider.dart';
import 'package:shamchiroq/models/provider.dart';
import 'package:shamchiroq/models/style.dart';
import 'package:shamchiroq/models/user_data.dart';
import 'package:shamchiroq/screens/dashboard/dashboard.dart';
import 'package:shamchiroq/screens/login/activate.dart';
import 'package:shamchiroq/screens/login/login.dart';
import 'package:shamchiroq/screens/login/set_password.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  String api = "https://shamchiroq.m1.uz";
  List<String> listAudios = [];
  bool isLogin = false;
  bool isMatchedNewPhone = false;
  Future<void> register(TextEditingController controller, context) async {
    Uri url = Uri.parse("$api/api/v1/validate-phone-number/");
    if (controller.text.isNotEmpty) {
      final response = await http.post(url, body: {
        "phone_number":
            "${controller.text.substring(0, 2)}${controller.text.substring(3, 6)}${controller.text.substring(7, 9)}${controller.text.substring(10, 12)}"
      });
      if (response.statusCode == 200) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Activate(
                phoneNumber:
                    "${controller.text.substring(0, 2)}${controller.text.substring(3, 6)}${controller.text.substring(7, 9)}${controller.text.substring(10, 12)}"),
          ),
        );
      } else {
        return;
      }
    } else {
      return;
    }
  }

  bool isCodeCorrect = false;
  Future<void> active(context, TextEditingController controller,
      String phoneNumber, bool isCorrectCode) async {
    Uri url = Uri.parse("$api/api/v1/validate-otp/");

    final response = await http.post(url, body: {
      "code": controller.text,
      "phone_number": phoneNumber,
    });
    final body = jsonDecode(response.body);
    print(body["status"].runtimeType);
    if (body["status"] == true) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Password(
            phoneNumber: phoneNumber,
          ),
        ),
      );
    } else {
      isCodeCorrect = body["status"];
      print(isCodeCorrect);
    }
  }

  Future<void> password(
      TextEditingController controller, String phoneNumber, context) async {
    Uri url = Uri.parse("$api/api/v1/user-register/");

    final response = await http.post(url,
        body: {"phone_number": phoneNumber, "password": controller.text});
    final body = jsonDecode(response.body);
    print(body);
    print(response.statusCode);
    if (response.statusCode >= 200 || response.statusCode <= 300) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const Login(),
        ),
      );
    } else {
      return;
    }
  }

  Future<void> login(TextEditingController phoneNumber,
      TextEditingController password, context) async {
    Uri url = Uri.parse("${Api().api}/api/v1/login/");

    final response = await http.post(url, body: {
      "phone_number":
          "${phoneNumber.text.substring(0, 2)}${phoneNumber.text.substring(3, 6)}${phoneNumber.text.substring(7, 9)}${phoneNumber.text.substring(10, 12)}",
      "password": password.text,
    });
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      isLogin = true;
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Dashboard()));
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString("accessToken", body["access_token"]);
      await pref.setString("refreshToken", body["refresh_token"]);
      await pref.setInt("userId", body["user"]["pk"]);
      await pref.setBool("isLoggedIn", isLogin);
    } else {        
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Telefon raqam yoki parol xato!",
            style: TextStyle(fontSize: 16, fontFamily: kRoboto),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  bool isError = false;
  Future<UserData> userData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final id = pref.getInt("userId");
    var token = pref.getString("accessToken");
    final refreshToken = pref.getString("refreshToken");
    Uri url = Uri.parse("$api/api/v1/user-detail/$id/");
    final response = await http.get(
      url,
    );
    if (response.statusCode == 200) {
      UserData data = userDataFromJson(response.body);
      return data;
    } else if (response.statusCode == 401) {
      var response = await http.post(Uri.parse("$url/api/v1/token/refresh/"),
          body: {"refresh": refreshToken});
      final body = jsonDecode(response.body);
      await pref.setString("accessToken", body['access']);
      token = body["access"];
      return userData();
    } else {
      return throw Exception("Failed");
    }
  }

  Future<void> changePhoneNumber(context, String controller) async {
    final data = Provider.of<Data>(context, listen: false);

    SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString("accessToken");

    Uri url = Uri.parse("$api/api/v1/change-phone-number/");
    final response = await http.post(url, body: {
      "phone_number": data.dataModel?.phoneNumber,
      "new_phone": controller
    }, headers: {
      "Authorization": "Bearer $token"
    });
    final body = jsonDecode(response.body);
    print(body);
    if (body["detaild"] == "Otp send succesfully") {
      print("ok");
    } else if (response.statusCode == 401) {
    } else {
      print(body);
    }
  }

  Future<void> changePhoneNumberOtp(String newPhone, String code) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var token = pref.getString("accessToken");

    final refreshToken = pref.getString("refreshToken");
    final response = await http.post(
        Uri.parse("$api/api/v1/validate-new-phone-otp/"),
        body: {"new_phone": newPhone, "code": code},
        headers: {"Authorization": "Bearer $token"});

    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      isMatchedNewPhone = true;
      await pref.setBool("isMatched", isMatchedNewPhone);
    } else if (response.statusCode == 401) {
      var response = await http.post(Uri.parse("$api/api/v1/token/refresh/"),
          body: {"refresh": refreshToken});
      final body = jsonDecode(response.body);
      await pref.setString("accessToken", body['access']);
      token = body["access"];
      return changePhoneNumberOtp(newPhone, code);
    } else {
      return;
    }
  }

  static Future<File?> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result == null) return null;
    return File(result.files.single.path!);
  }
  
}
