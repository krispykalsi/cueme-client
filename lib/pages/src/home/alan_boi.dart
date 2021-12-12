import 'package:alan_voice/alan_voice.dart';
import 'package:cueme/models/cueme_request.dart';
import 'package:cueme/models/mediums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AlanBoi extends StatefulWidget {
  final Widget child;
  final void Function(CuemeRequest) onCue;

  const AlanBoi({Key? key, required this.child, required this.onCue})
      : super(key: key);

  @override
  _AlanBoiState createState() => _AlanBoiState();
}

class _AlanBoiState extends State<AlanBoi> {
  String? email;
  String? phone;
  String msg = "<NO MESSAGE>";
  String? date;
  int? time;
  bool sendEmail = false;
  bool sendMsg = false;
  bool sendWhatsapp = false;

  _AlanBoiState() {
    final authKey = dotenv.get("ALAN_SDK_AUTH_KEY");
    if (authKey.isNotEmpty) {
      AlanVoice.addButton(authKey);
      AlanVoice.callbacks.add((command) => _handleCommands(command.data));
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _handleCommands(Map<String, dynamic> response) {
    if (response[command] == emailCmd) {
      email = response[data];
    }
    if (response[command] == phoneCmd) {
      phone = response[data];
      debugPrint(phone);
    }
    if (response[command] == msgCmd) {
      msg = response[data];
    }
    if (response[command] == emailFlagCmd) {
      sendEmail = true;
    }
    if (response[command] == whatsappFlagCmd) {
      sendWhatsapp = true;
    }
    if (response[command] == messageFlagCmd) {
      sendMsg = true;
    }
    if (response[command] == dateCmd) {
      date = response[data];
    }
    if (response[command] == timeCmd) {
      time = response[data];
    }
    if (response[command] == cueCmd) {
      _onFinalCue();
    }
  }

  void _onFinalCue() {
    var dateTime = date == null ? DateTime.now() : DateTime.parse(date!);
    TimeOfDay timeOfDay;
    if (time == null) {
      int secondsSinceMidnight = time ?? 0;
      int hour = (secondsSinceMidnight / 3600) as int;
      int minutes = ((secondsSinceMidnight / 60) as int) % 60;
      timeOfDay = TimeOfDay(hour: hour, minute: minutes);
    } else {
      timeOfDay = TimeOfDay.now();
    }

    var mediumSelectionState = <Mediums, bool>{};
    mediumSelectionState[Mediums.wa] = sendWhatsapp;
    mediumSelectionState[Mediums.email] = sendEmail;
    mediumSelectionState[Mediums.sms] = sendMsg;

    final mediums = mediumSelectionState.entries
        .where((isSelected) => isSelected.value)
        .map<Mediums>((isSelected) => isSelected.key)
        .toSet();

    final req = CuemeRequest(msg, dateTime, timeOfDay,
        mediums: mediums, phone: phone, email: email);
    widget.onCue(req);
  }

  static const command = "command";
  static const data = "data";

  static const msgCmd = "msg";
  static const phoneCmd = "phone";
  static const emailCmd = "email";
  static const dateCmd = "date";
  static const timeCmd = "time";

  static const whatsappFlagCmd = "whatsappFlag";
  static const emailFlagCmd = "emailFlag";
  static const messageFlagCmd = "messageFlag";

  static const cueCmd = "cue";
}
