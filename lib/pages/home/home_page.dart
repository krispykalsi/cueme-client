import 'package:flutter/material.dart';
import 'package:alan_voice/alan_voice.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import 'input_field.dart';
import 'date_time_picker.dart';
import 'medium_choice_buttons.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _alanCallback(command) {
    debugPrint("got new command ${command.toString()}");
  }

  _HomePageState() {
    AlanVoice.addButton(
        "6ca645cf90c533067cb872151c493bf52e956eca572e1d8b807a3e2338fdd0dc/stage");
  }

  @override
  void initState() {
    super.initState();
    AlanVoice.onCommand.add(_alanCallback);
  }

  @override
  void dispose() {
    AlanVoice.onCommand.remove(_alanCallback);
    super.dispose();
  }

  final subjectController = TextEditingController();
  final contactController = TextEditingController();
  final messageController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Cueme'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          children: <Widget>[
            InputField(
              label: 'Email',
              hint: 'Enter your email',
              controller: emailController,
            ),
            InputField(
              label: 'Contact',
              hint: 'Enter your phone number',
              controller: contactController,
            ),
            InputField(
              label: 'Subject',
              hint: 'Enter subject for mail',
              controller: subjectController,
            ),
            InputField(
              label: 'Body',
              hint: 'Enter Message',
              controller: messageController,
            ),
            DateTimePicker(
              onDateSet: (date) {},
              onTimeSet: (time) {},
            ),
            MediumChoiceButtons(
              onChange: (selectionState) {},
            ),
            ElevatedButton(
              onPressed: () {
                String data = '{"email":"' +
                    emailController.text +
                    '","message":"' +
                    messageController.text +
                    '","phone":"' +
                    contactController.text +
                    '"}';
                callAPI(data);
              },
              child: const Text('Cue'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> callAPI(String data) async {
    String url = 'http://192.168.1.6:3000/api';
    final http.Response response = await http.post(
      Uri.parse(url + '/wa'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: data,
    );

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Your Cue Was Successful :)",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        // backgroundColor: Colors.red,
        // textColor: Colors.white,
        // fontSize: 16.0
      );
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      Fluttertoast.showToast(
        msg: "'A Failed Cue.Try Again :(",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        // backgroundColor: Colors.red,
        // textColor: Colors.white,
        // fontSize: 16.0
      );
      throw Exception('A Failed Cue.Try Again :( \nreason: ' +
          (response.reasonPhrase ?? "Unknown"));
    }
  }
}
