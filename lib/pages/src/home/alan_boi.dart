import 'package:alan_voice/alan_voice.dart';
import 'package:cueme/models/cueme_request.dart';
import 'package:cueme/models/mediums.dart';
import 'package:flutter/material.dart';

class AlanBoi extends StatefulWidget {
  final Widget child;
  final void Function(CuemeRequest) onCue;

  const AlanBoi({Key? key, required this.child, required this.onCue})
      : super(key: key);

  @override
  _AlanBoiState createState() => _AlanBoiState();
}

class _AlanBoiState extends State<AlanBoi> {
  dynamic email;
  dynamic number;
  dynamic msg;
  dynamic date;
  dynamic time;
  dynamic sendEmail = false;
  dynamic sendMsg = false;
  dynamic sendWhatsapp = false;

  _AlanBoiState() {
    const authKey = bool.hasEnvironment("ALAN_SDK_AUTH_KEY")
        ? String.fromEnvironment("ALAN_SDK_AUTH_KEY")
        : null;
    if (authKey != null) {
      AlanVoice.addButton(authKey);
      AlanVoice.callbacks.add((command) => _handleCommands(command.data));
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _handleCommands(Map<String, dynamic> response) {
    if (response["command"] == "email") {
      email = response["data"];
    }
    if (response["command"] == "phone") {
      number = response["data"];
    }
    if (response["command"] == "msg") {
      msg = response["data"];
    }
    if (response["command"] == "emailfinal") {
      sendEmail = true;
    }
    if (response["command"] == "wtspyes") {
      sendWhatsapp = true;
    }
    if (response["command"] == "smsyes") {
      sendMsg = true;
    }
    if (response["command"] == "date") {
      date = response["data"];
    }
    if (response["command"] == "time") {
      time = response["data"];
    }
    if (response["command"] == "finalCue") {
      _onFinalCue();
    }
  }

  void _onFinalCue() {
    var date = DateTime.now();
    var time = TimeOfDay.now();
    var mediumSelectionState = <Mediums, bool>{};
    mediumSelectionState[Mediums.wa] = sendWhatsapp;
    mediumSelectionState[Mediums.email] = sendEmail;
    mediumSelectionState[Mediums.sms] = sendMsg;

    final mediums = mediumSelectionState.entries
        .where((isSelected) => isSelected.value)
        .map<Mediums>((isSelected) => isSelected.key)
        .toSet();

    final req = CuemeRequest(msg, date, time,
        mediums: mediums, phone: "+91" + number, email: email);
    widget.onCue(req);
  }
}
