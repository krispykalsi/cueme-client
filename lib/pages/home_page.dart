import 'dart:async';

import 'package:cueme/api/cueme_api.dart';
import 'package:cueme/models/cueme_request.dart';
import 'package:cueme/models/mediums.dart';
import 'package:cueme/widgets/handle_response.dart';
import 'package:cueme/widgets/show_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:alan_voice/alan_voice.dart';

import 'src/home/request_form.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  dynamic tempemail;
  dynamic tempenumber;
  dynamic tempemsg;
  dynamic tempdate;
  dynamic temptime;
  dynamic isemail;
  dynamic ismsg;
  dynamic iswtsp;
  

  _HomePageState() {
  /// Init Alan Button with project key from Alan Studio      
    AlanVoice.addButton("eaca2cbbc44dfb01c1386ac5152de8472e956eca572e1d8b807a3e2338fdd0dc/stage");

    /// Handle commands from Alan Studio
    AlanVoice.callbacks.add((command)=>_handleCommands(command.data));
  }

  final api = const CuemeApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Cueme'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: RequestForm(onCue: _onCue),
        ),
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

  _handleCommands(Map <String, dynamic> response){
    if(response["command"]=="email"){
      tempemail = response["data"];
    }
    if(response["command"]=="phone"){
      tempenumber=response["data"];
    }
    if(response["command"]=="msg"){
      tempemsg=response["data"];
    }
    if(response["command"]=="emailfinal"){
      isemail="yes";
    }
    if(response["command"]=="wtspyes"){
      iswtsp="yes";
    }
    if(response["command"]=="smsyes"){
      ismsg="yes";
    }
    if(response["command"]=="date"){
      tempdate = response["data"];
    }
    if(response["command"]=="time"){
      temptime = response["data"];
    }
    if(response["command"]=="finalCue"){
      // call api.
    }
    print(response);
  }
}


