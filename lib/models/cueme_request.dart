import 'dart:convert';

import 'package:flutter/material.dart';

import 'mediums.dart';

class CuemeRequest {
  final String? email;
  final String? phone;
  final String message;
  final DateTime date;
  final TimeOfDay time;
  final Set<Mediums> mediums;

  CuemeRequest(
    this.message,
    this.date,
    this.time, {
    this.email,
    this.phone,
    required this.mediums,
  })  : assert(email != null || phone != null),
        assert(mediums.isNotEmpty);

  String toJson() {
    final rfc3339Time = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    ).toUtc().toIso8601String();
    final jsonMap = <String, dynamic>{
      "message": message,
      "email": email ?? "",
      "phone": phone ?? "",
      "time": rfc3339Time,
    };
    return jsonEncode(jsonMap);
  }
}
