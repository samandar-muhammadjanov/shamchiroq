// To parse this JSON data, do
//
//     final audio = audioFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<String> audioFromJson(String str) => List<String>.from(json.decode(str).map((x) => x));

String audioToJson(List<String> data) => json.encode(List<dynamic>.from(data.map((x) => x)));
