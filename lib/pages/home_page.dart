import 'package:cueme/api/cueme_api.dart';
import 'package:cueme/models/cueme_request.dart';
import 'package:cueme/pages/home/request_form.dart';
import 'package:flutter/material.dart';
import 'package:alan_voice/alan_voice.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _HomePageState() {
    AlanVoice.addButton(
        "6ca645cf90c533067cb872151c493bf52e956eca572e1d8b807a3e2338fdd0dc/stage");
  }

  final api = const CuemeApi();

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

  void _alanCallback(command) {
    debugPrint("got new command ${command.toString()}");
  }

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
        child: RequestForm(onCue: _onCue),
      ),
    );
  }

  void _onCue(CuemeRequest req) async {
    final successStatus = {for (var medium in Mediums.values) medium: true};
    showLoadingIndicator(context);
    await api.request(req).forEach(
      (tuple) {
        final medium = tuple.item1;
        final response = tuple.item2;
        successStatus[medium] = response.statusCode == 200;
      },
    );
    Navigator.pop(context);
    handleResponse(successStatus);
  }

  void handleResponse(http.Response response) {
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
