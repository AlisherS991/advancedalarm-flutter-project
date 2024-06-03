
import 'package:advancedalarm/notification_widgets/notification_helper.dart';
import 'package:advancedalarm/screens/my_app.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
NotificationHelper.init();

  runApp(const MyApp());
}
