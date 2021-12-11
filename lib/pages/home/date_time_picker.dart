import 'package:flutter/material.dart';

class DateTimePicker extends StatefulWidget {
  final Function(DateTime) onDateSet;
  final Function(TimeOfDay) onTimeSet;

  const DateTimePicker({
    Key? key,
    required this.onDateSet,
    required this.onTimeSet,
  }) : super(key: key);

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  DateTime pickedDate = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              "Date: ${pickedDate.day}, ${pickedDate.month}, ${pickedDate.year}",
            ),
            trailing: const Icon(Icons.keyboard_arrow_down),
            onTap: _pickDate,
          ),
          ListTile(
            title: Text("Time: ${time.hour}: ${time.minute}"),
            trailing: const Icon(Icons.keyboard_arrow_down),
            onTap: _pickTime,
          ),
        ],
      ),
    );
  }

  void _pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
      initialDate: pickedDate,
    );
    if (date != null) {
      widget.onDateSet(date);
      setState(() => pickedDate = date);
    }
  }

  void _pickTime() async {
    TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: time,
    );
    if (newTime != null) {
      widget.onTimeSet(newTime);
      setState(() => time = newTime);
    }
  }
}
