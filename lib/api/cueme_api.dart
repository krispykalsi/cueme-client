import 'package:cueme/models/cueme_request.dart';
import 'package:cueme/models/mediums.dart';
import 'package:http/http.dart' as http;
import 'package:tuple/tuple.dart';

class CuemeApi {
  const CuemeApi();

  Stream<Tuple2<Mediums, http.Response>> request(CuemeRequest req) async* {
    for (final medium in req.mediums) {
      final http.Response res = await http.post(
        Uri.parse(baseUrl + medium.name),
        headers: {'Content-Type': 'application/json'},
        body: req.toJson(),
      );
      yield Tuple2(medium, res);
    }
  }

  static const baseUrl = 'http://cueme.xyz/api/';
}
