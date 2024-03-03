import 'package:flutter/material.dart';

class PlacedResponse{
  dynamic data;
  bool success;
  Exception? error;

  PlacedResponse({
    required this.data,
    required this.success,
    this.error
  });
}