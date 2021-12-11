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
    final jsonMap = <String, dynamic>{
      "message": message,
      "email": email ?? "",
      "phone": phone ?? "",
    };
    return jsonEncode(jsonMap);
  }
}
