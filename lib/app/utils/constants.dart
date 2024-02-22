import 'dart:io';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

/// Returns the app's default snackbar with a [text].
SnackBar _getGenericSnackbar(String text, bool isError) {
  return SnackBar(
    content: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: isError ? Colors.red : Colors.white,
        fontSize: 16.0,
      ),
    ),
  );
}

/// Shows a generic [Snackbar]
void showGenericSnackbar(GlobalKey<ScaffoldMessengerState> key, String text,
    {bool isError = false}) {
  key.currentState!.showSnackBar(_getGenericSnackbar(text, isError));
}