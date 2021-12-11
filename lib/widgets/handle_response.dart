import 'package:cueme/models/mediums.dart';
import 'package:fluttertoast/fluttertoast.dart';

void handleResponse(Map<Mediums, bool> successStatus) {
  final unsuccessfulCues = <String>[];
  for (var cue in successStatus.entries) {
    final medium = cue.key;
    final wasSuccessful = cue.value;
    if (!wasSuccessful) {
      unsuccessfulCues.add(medium.longName);
    }
  }

  if (unsuccessfulCues.isEmpty) {
    Fluttertoast.showToast(
      msg: "Your Cues were successful :)",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
    );
  } else {
    Fluttertoast.showToast(
      msg: "Some Cues failed ($unsuccessfulCues) :( Try again later",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
    );
  }
}
