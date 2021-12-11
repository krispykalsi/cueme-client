import 'package:cueme/models/cueme_request.dart';
import 'package:http/http.dart' as http;

class CuemeApi {
  const CuemeApi();

  Stream<http.Response> request(CuemeRequest req) async* {
    for (final medium in req.mediums) {
      final http.Response res = await http.post(
        Uri.parse(baseUrl + medium.name),
        headers: {'Content-Type': 'application/json'},
        body: req.toJson(),
      );
      yield res;
    }
  }

  static const baseUrl = 'http://cueme.xyz/api/';
}
