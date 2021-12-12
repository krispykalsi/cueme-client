import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart' as shelf_router;
import 'package:shelf_static/shelf_static.dart' as shelf_static;

Future main() async {
  final port = int.parse(Platform.environment['PORT'] ?? '5000');

  final cascade = Cascade().add(_staticHandler).add(_router);

  final server = await shelf_io.serve(
    logRequests().addHandler(cascade.handler),
    InternetAddress.anyIPv4,
    port,
  );

  print('Serving at http://${server.address.host}:${server.port}');
}

final _staticHandler =
    shelf_static.createStaticHandler('public', defaultDocument: 'index.html');

final _router = shelf_router.Router()..get('/api', _apiRoute);

Response _apiRoute(Request request) => Response.ok(
      JsonEncoder.withIndent(' ').convert({
        "info": "Welcome to the CuemeApi",
        "routes": {
          "whatsapp": "cueme.xyz/api/wa",
          "sms": "cueme.xyz/api/sms",
          "email": "cueme.xyz/api/email",
        },
        "schema": {
          "message": "hello cueme :3",
          "phone": "+919876543210",
          "email": "joe@mama.com",
          "time": "2021-07-25T15:59:59.000Z"
        }
      }),
    );
