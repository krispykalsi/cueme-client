import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    time  = TimeOfDay.now();
  }

  final subject=TextEditingController();
  final contact=TextEditingController();
  final message=TextEditingController();
  final email=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:false,
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
                  ),controller: message,            
                ),  
              ),  
              Padding(  
                padding: EdgeInsets.all(5),  
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text("Date: ${pickedDate.day}, ${pickedDate.month}, ${pickedDate.year}"),
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
                        Icon(FontAwesomeIcons.whatsapp),
                        Icon(Icons.mail),
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
                onPressed: (){
                    print(subject.text);
                    print(contact.text);
                    print(message.text);
                    print(time);
                    print(pickedDate);
                    print(_selection[0]);
                    print(_selection[1]);
                    print(_selection[2]);
                  },
                child: const Text('Cue'),
              ), 
            ],  
          )  
      )  

    );
  }
  _pickDate() async{
    DateTime? date = await showDatePicker(
      context: context, 
      firstDate: DateTime(DateTime.now().year), 
      lastDate: DateTime(DateTime.now().year+1),
      initialDate: pickedDate,
    );
    if(date != null)
    setState(() {
      pickedDate=date;
    });
  }
    _pickTime() async{
    TimeOfDay? newtime = await showTimePicker(
      context: context, 
      initialTime: time,
    );
    if(newtime != null)
    setState(() {
      time=newtime;
    });
  }
}
