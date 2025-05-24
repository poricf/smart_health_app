import 'dart:async';
import '../services/bluetooth_service.dart';
import '../services/api_service.dart';

class HealthController {
  final BluetoothService _bluetoothService;
  final ApiService _apiService;
  late final StreamSubscription<Map<String, dynamic>> _subscription;

  HealthController(this._bluetoothService, this._apiService);

  void startListening() {
    _subscription = _bluetoothService.healthDataStream.listen((data) async {
      print("Received from BLE: $data");
      try {
        await _apiService.sendMetricData(data);
        print("✅ Data sent to server");
      } catch (e) {
        print("❌ Failed to send data: $e");
      }
    });
  }

  void stopListening() {
    _subscription.cancel();
  }
}
