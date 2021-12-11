import 'package:cueme/models/cueme_request.dart';
import 'package:cueme/models/mediums.dart';
import 'package:flutter/material.dart';

import 'input_field.dart';
import 'date_time_picker.dart';
import 'medium_choice_buttons.dart';

class RequestForm extends StatefulWidget {
  final void Function(CuemeRequest) onCue;

  const RequestForm({Key? key, required this.onCue}) : super(key: key);

  @override
  State<RequestForm> createState() => _RequestFormState();
}

class _RequestFormState extends State<RequestForm> {
  var date = DateTime.now();
  var time = TimeOfDay.now();

  final phoneController = TextEditingController();
  final messageController = TextEditingController();
  final emailController = TextEditingController();

  var mediumSelectionState = <Mediums, bool>{};

  void _onCueTap() {
    final email = emailController.text;
    final phone = "+91" + phoneController.text;
    final msg = messageController.text;

    final mediums = mediumSelectionState.entries
        .where((isSelected) => isSelected.value)
        .map<Mediums>((isSelected) => isSelected.key)
        .toSet();

    final req = CuemeRequest(msg, date, time,
        mediums: mediums, phone: phone, email: email);
    widget.onCue(req);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InputField(
          label: 'Email',
          hint: 'Enter your email',
          controller: emailController,
        ),
        InputField(
          label: 'Contact',
          hint: 'Enter your phone number',
          controller: phoneController,
        ),
        InputField(
          label: 'Body',
          hint: 'Enter Message',
          controller: messageController,
        ),
        DateTimePicker(
          onDateSet: (newDate) => date = newDate,
          onTimeSet: (newTime) => time = newTime,
        ),
        MediumChoiceButtons(
          onChange: (selectionState) => mediumSelectionState = selectionState,
        ),
        ElevatedButton(
          onPressed: _onCueTap,
          child: const Text('Cue'),
        ),
      ],
    );
  }
}
