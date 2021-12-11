import 'package:cueme/models/mediums.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MediumChoiceButtons extends StatefulWidget {
  final void Function(Map<Mediums, bool>) onChange;

  const MediumChoiceButtons({Key? key, required this.onChange})
      : super(key: key);

  @override
  State<MediumChoiceButtons> createState() => _MediumChoiceButtonsState();
}

class _MediumChoiceButtonsState extends State<MediumChoiceButtons> {
  final _isSelected = List.filled(_mediumChoices.length, false);
  final _isSelectedMap = <Mediums, bool>{};

  void _onChoiceTap(int index) {
    setState(() => _isSelected[index] = !_isSelected[index]);
    _isSelectedMap[Mediums.wa] = _isSelected[indexWhatsapp];
    _isSelectedMap[Mediums.email] = _isSelected[indexEmail];
    _isSelectedMap[Mediums.sms] = _isSelected[indexMessage];
    widget.onChange(_isSelectedMap);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ToggleButtons(
        children: _mediumChoices,
        onPressed: _onChoiceTap,
        isSelected: _isSelected,
      ),
    );
  }

  static List<Widget> get _mediumChoices => const [
        Icon(Icons.message),
        Icon(FontAwesomeIcons.whatsapp),
        Icon(Icons.mail),
      ];

  static const indexMessage = 0;
  static const indexWhatsapp = 1;
  static const indexEmail = 2;
}
