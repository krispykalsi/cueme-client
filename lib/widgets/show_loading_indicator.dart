import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void showLoadingIndicator(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const _LoadingIndicatorDialog();
    },
  );
}

class _LoadingIndicatorDialog extends StatefulWidget {
  const _LoadingIndicatorDialog({Key? key}) : super(key: key);

  @override
  _LoadingIndicatorDialogState createState() => _LoadingIndicatorDialogState();
}

class _LoadingIndicatorDialogState extends State<_LoadingIndicatorDialog> {
  @override
  Widget build(BuildContext context) {
    return const Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: SpinKitWave(
        color: Colors.white,
        size: 50.0,
      ),
    );
  }
}
