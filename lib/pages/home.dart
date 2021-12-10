import 'package:flutter/material.dart';
import 'package:alan_voice/alan_voice.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late DateTime pickedDate;
  late TimeOfDay time;
  List<bool> _selection = List.generate(3, (_) => false);
  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
    time = TimeOfDay.now();
  }

  final subject = TextEditingController();
  final contact = TextEditingController();
  final message = TextEditingController();
  final email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('Cueme'),
          centerTitle: true,
        ),
        body: Padding(
            padding: EdgeInsets.only(top: 15),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter your email',
                    ),
                    controller: email,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Contact',
                      hintText: 'Number',
                    ),
                    controller: contact,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Subject',
                      hintText: 'Enter subject for mail',
                    ),
                    controller: subject,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Body',
                      hintText: 'Enter Message',
                    ),
                    controller: message,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(
                            "Date: ${pickedDate.day}, ${pickedDate.month}, ${pickedDate.year}"),
                        trailing: Icon(Icons.keyboard_arrow_down),
                        onTap: _pickDate,
                      ),
                      ListTile(
                        title: Text("Time: ${time.hour}: ${time.minute}"),
                        trailing: Icon(Icons.keyboard_arrow_down),
                        onTap: _pickTime,
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(15),
                    child: ToggleButtons(
                      children: [
                        Icon(Icons.message),
                        Icon(Icons.call),
                        Icon(Icons.cake),
                      ],
                      onPressed: (int index) {
                        int count = 0;
                        _selection.forEach((bool val) {
                          if (val) count++;
                        });
                        if (_selection[index] && count < 2) {
                          return;
                        }
                        setState(() {
                          _selection[index] = !_selection[index];
                        });
                      },
                      isSelected: _selection,
                    )),
                ElevatedButton(
                  onPressed: () {
                    print(subject.text);
                    print(contact.text);
                    print(message.text);
                    print(email.text);
                    String data = '{"email":"' +
                        email.text +
                        '","message":"' +
                        message.text +
                        '","phone":"' +
                        contact.text +
                        '"}';
                    print(data);
                    callAPI(data);
                  },
                  child: const Text('Cue'),
                ),
              ],
            )));
  }

  _pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 1),
      initialDate: pickedDate,
    );
    if (date != null)
      setState(() {
        pickedDate = date;
      });
  }

  _pickTime() async {
    TimeOfDay? newtime = await showTimePicker(
      context: context,
      initialTime: time,
    );
    if (newtime != null)
      setState(() {
        time = newtime;
      });
  }

  _HomeState() {
    /// Init Alan Button with project key from Alan Studio
    AlanVoice.addButton(
        "6ca645cf90c533067cb872151c493bf52e956eca572e1d8b807a3e2338fdd0dc/stage");

    /// Handle commands from Alan Studio
    AlanVoice.onCommand.add((command) {
      debugPrint("got new command ${command.toString()}");
    });
  }

  Future<void> callAPI(String data) async {
    print(data);
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
        msg: "Your Cue Was Succesfull :)",
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
      throw Exception('A Failed Cue.Try Again :(');
    }
  }
  // Future<http.Response> callAPI() async {
  //   String url = 'http://localhost:8080/api';
  //   final response = await http.get(Uri.parse('http://localhost:8080/api/sms'));

  //   if (response.statusCode == 200) {
  //     Fluttertoast.showToast(
  //       msg: "Your Cue Was Succesfull :)",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.CENTER,
  //       timeInSecForIosWeb: 1,
  //       // backgroundColor: Colors.red,
  //       // textColor: Colors.white,
  //       // fontSize: 16.0
  //     );
  //     return response;
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     throw Exception('A Failed Cue.Try Again :(');
  //   }
  // }

}
