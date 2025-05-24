import 'dart:async';
import 'dart:math';

class BluetoothService {
  final _controller = StreamController<Map<String, dynamic>>();
  final Random _random = Random();

  Stream<Map<String, dynamic>> get healthDataStream => _controller.stream;

  BluetoothService() {
    // Simulate incoming data every 2 seconds
    Timer.periodic(const Duration(seconds: 2), (_) {
      final data = {
        "heartRate": 70 + _random.nextInt(20),
        "spo2": 95 + _random.nextInt(5),
        "temperature": 36.5 + _random.nextDouble(),
        "bloodPressure": {
          "systolic": 110 + _random.nextInt(15),
          "diastolic": 70 + _random.nextInt(10),
        },
        "timestamp": DateTime.now().toIso8601String(),
        "deviceId": "mock-watch-001"
      };
      _controller.add(data);
    });
  }

  void dispose() {
    _controller.close();
  }
}
