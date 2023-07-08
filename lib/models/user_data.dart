import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));
String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
    UserData({
        required this.password,
        required this.phoneNumber,
    });

    String phoneNumber;
    String password;

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        phoneNumber: json["phone_number"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "phone_number": phoneNumber,
        "password": password,
    };
}
