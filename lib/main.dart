import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:shamchiroq/models/provider.dart';
import 'package:shamchiroq/models/style.dart';
import 'package:shamchiroq/screens/dashboard/dashboard.dart';
import 'package:shamchiroq/screens/intro_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("url");
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var isLoggedIn = (prefs.getBool('isLoggedIn') == null)
      ? false
      : prefs.getBool('isLoggedIn');
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      statusBarColor: Colors.white
       // navigation bar color // status bar color
    ),
  );
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider<Data>(create: (context) => Data())],
      child: MaterialApp(
        title: "Shamchiroq",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: kColor,
        ),
        home: isLoggedIn! ? const Dashboard() : const IntroScreen(),
      ),
    ),
  );
}
