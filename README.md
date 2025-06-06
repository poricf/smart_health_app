## 📱 Smart Health Monitoring App

A modern, cross-platform Flutter mobile app that connects to wearable health devices via Bluetooth and displays real-time and historical health metrics. The app is built with glassmorphic UI, dark theme, and supports doctor-side backend sync.

---

### 🚀 Features

* 📡 **Bluetooth Device Connection**

  * Receives real-time health data in JSON format from BLE device
  * Sends to backend server for doctor monitoring
* 📈 **Live & Historical Health Monitoring**

  * Metrics: Heart Rate, SpO₂, Temperature, Blood Pressure
  * 24-Hour live stream + Weekly & Monthly analysis
* 🏃 **Step Count Integration** *(mocked)*
* 🛌 **Sleep Monitoring Summary**
* ⚖️ **BMI Calculator**
* 👤 **User Profile & Device Status**
* 📊 **Stats Page with Smart Insights**

  * Weekly & monthly charts per metric
  * Health status interpretation

---

### 🧱 Tech Stack

| Layer        | Technology                      |
| ------------ | ------------------------------- |
| Framework    | Flutter (Dart)                  |
| BLE Comm     | `flutter_reactive_ble`          |
| UI Framework | `google_fonts`, `fl_chart`      |
| State        | Stateful Widgets                |
| Networking   | `http` (custom API)             |
| Backend      | Custom API (Node, Django, etc.) |
| Auth         | (Pluggable: Firebase, JWT)      |

---

### 📦 Installation

```bash
flutter pub get
flutter run
```

Add your own BLE device and server endpoint setup in:

* `bluetooth_service.dart`
* `api_service.dart`

---

### 📡 Bluetooth Format

**Expected JSON format from BLE:**

```json
{
  "heartRate": 75,
  "spo2": 97,
  "temperature": 36.8,
  "bloodPressure": { "systolic": 120, "diastolic": 80 },
  "timestamp": "2025-05-31T12:34:56Z",
  "deviceId": "watch001"
}
```

---

### 📤 API Contract

* `POST /api/v1/metrics` — Send live data
* `GET /api/v1/metrics/user/{userId}?type=spo2&period=weekly` — Get data for charts

---

### 📁 Project Structure

```
lib/
├── main.dart
├── ui/
│   ├── home_screen.dart
│   ├── stats_screen.dart
│   ├── profile_screen.dart
│   └── bmi_screen.dart
├── widgets/
│   ├── health_card.dart
│   ├── live_chart.dart
│   ├── weekly_chart.dart
│   ├── monthly_chart.dart
│   └── ...
├── services/
│   ├── bluetooth_service.dart
│   └── api_service.dart
```

---

### 💡 Future Roadmap

* [ ] Step counter via native sensor API
* [ ] Real sleep tracking via device API
* [ ] Firebase Auth integration
* [ ] Notification system
* [ ] Doctor dashboard UI (web)

---

### 🧑‍⚕️ Designed for:

* Medical staff (via dashboard)
* Patients with wearables
* Long-term health tracking

---



