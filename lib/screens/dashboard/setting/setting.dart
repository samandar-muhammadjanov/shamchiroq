import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:shamchiroq/models/provider.dart';
import 'package:shamchiroq/models/style.dart';
import 'package:shamchiroq/screens/dashboard/setting/companents/settings_mgmt.dart';
import 'package:shamchiroq/widgets/subscription.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  List<String> voices = ["Erkak ovozi", "Ayol ovozi"];
  String selectedVoice = '';
  var maskFormatter = MaskTextInputFormatter(
      mask: '+998(##)###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  bool isChanged = false;
  final TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    isChanged = false;
    selectedVoice = "Erkak ovozi";
    final data = Provider.of<Data>(context, listen: false);
    data.fetchUserData();
    final phone = data.dataModel?.phoneNumber;
    controller.text =
        "+998(${phone?.substring(0, 2)})${phone?.substring(2, 5)}-${phone?.substring(5, 7)}-${phone?.substring(7, 9)}";
    selectedVoiceFunc();
  }

  void selectedVoiceFunc() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("selectedVoice", selectedVoice);
    setState(() {
      selectedVoice = pref.getString("selectedVoice")!;
    });
  }

  String newPhone = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithAction(context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sozlamalar",
                style: TextStyle(
                    color: const Color.fromRGBO(200, 212, 227, 1),
                    fontSize: 20,
                    fontFamily: kRoboto),
              ),
              const SizedBox(
                height: 15,
              ),
             SettingMGMT(selectedVoice: selectedVoice, voices: voices, isChanged: isChanged, newPhone: newPhone, controller: controller, maskFormatter: maskFormatter),
              const SizedBox(
                height: 20,
              ),
              const Subscription(),
            ],
          ),
        ),
      ),
    );
  }

}
