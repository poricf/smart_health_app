import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'ui/home_screen.dart';
import 'ui/starter_screen.dart';
import 'controllers/health_controller.dart';
import 'services/bluetooth_service.dart';
import 'services/api_service.dart';
import 'screens/main_navigation.dart';

late HealthController healthController;

void main() {

  final bleservice = BluetoothService();
  final apiservice = ApiService();
  healthController = HealthController(bleservice, apiservice);
  runApp(DevicePreview(
    enabled: true,
    builder: (context) => HealthMonitorApp(),
  ));
}

class HealthMonitorApp extends StatelessWidget {
  const HealthMonitorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Health Monitor',
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.transparent),
      home: const MainNavigation(),
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
    );
  }
}
