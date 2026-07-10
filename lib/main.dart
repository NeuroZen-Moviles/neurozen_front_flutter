import 'package:flutter/material.dart';
import 'app/app.dart';

import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    final google = await InternetAddress.lookup("google.com");
    debugPrint("Google: $google");
  } catch (e) {
    debugPrint("Google ERROR: $e");
  }

  try {
    final render = await InternetAddress.lookup(
      "neurozen-backend-mobile.onrender.com",
    );
    debugPrint("Render: $render");
  } catch (e) {
    debugPrint("Render ERROR: $e");
  }

  runApp(const NeurozenApp());
}
