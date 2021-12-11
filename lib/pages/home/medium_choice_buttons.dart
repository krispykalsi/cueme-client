import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MediumChoiceButtons extends StatefulWidget {
  final void Function(List<bool>) onChange;

  const MediumChoiceButtons({Key? key, required this.onChange})
      : super(key: key);

  @override
  State<MediumChoiceButtons> createState() => _MediumChoiceButtonsState();
}

class _MediumChoiceButtonsState extends State<MediumChoiceButtons> {
  final _isSelected = List.filled(_mediumChoices.length, false);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ToggleButtons(
        children: _mediumChoices,
        onPressed: (int index) {
          setState(() => _isSelected[index] = !_isSelected[index]);
          widget.onChange(_isSelected);
        },
        isSelected: _isSelected,
      ),
    );
  }

  static List<Widget> get _mediumChoices => const [
        Icon(Icons.message),
        Icon(FontAwesomeIcons.whatsapp),
        Icon(Icons.mail),
      ];
}

class Mediums {
  static const message = 0;
  static const whatsapp = 1;
  static const email = 2;
}
