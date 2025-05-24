import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/health_card.dart';
import '../widgets/live_chart.dart';
import '../widgets/weekly_chart.dart';
import '../widgets/monthly_chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedMetric = "SpO₂";
  String selectedPeriod = "24 HR";

  final List<String> metrics = ["SpO₂", "Heart Rate", "Temp", "BP"];
  final List<String> periods = ["24 HR", "Weekly", "Monthly"];

  final List<Map<String, dynamic>> mockWeeklyData = [
    {"day": "Mon", "value": 97},
    {"day": "Tue", "value": 96},
    {"day": "Wed", "value": 98},
    {"day": "Thu", "value": 95},
    {"day": "Fri", "value": 97},
    {"day": "Sat", "value": 98},
    {"day": "Sun", "value": 96},
  ];

  final List<Map<String, dynamic>> mockMonthlyData = List.generate(30, (index) {
    return {"day": index + 1, "value": 95 + (index % 5)};
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.menu, color: Colors.white),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.notifications_none, color: Colors.white),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello Fahmi 👋",
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),

                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 1.1,
                  children: const [
                    HealthCard(
                      title: "Heart Rate",
                      value: "78 bpm",
                      icon: Icons.favorite,
                      iconColor: Color(0xFFFFD700),
                    ),
                    HealthCard(
                      title: "Temperature",
                      value: "37°C",
                      icon: Icons.thermostat,
                      iconColor: Color(0xFFFFD700),
                    ),
                    HealthCard(
                      title: "SpO₂",
                      value: "98%",
                      icon: Icons.bloodtype,
                      iconColor: Color(0xFFFFD700),
                    ),
                    HealthCard(
                      title: "Blood Pressure",
                      value: "120/80",
                      icon: Icons.monitor_heart,
                      iconColor: Color(0xFFFFD700),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                Row(
                  children: [
                    Expanded(
                      child: buildDropdown(
                        label: "Metric",
                        value: selectedMetric,
                        options: metrics,
                        onChanged: (val) => setState(() => selectedMetric = val!),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: buildDropdown(
                        label: "Duration",
                        value: selectedPeriod,
                        options: periods,
                        onChanged: (val) => setState(() => selectedPeriod = val!),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                Container(
                  height: height * 0.3,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      )
                    ],
                  ),
                  padding: const EdgeInsets.all(12),
                  child: selectedPeriod == "24 HR"
                      ? const LiveChart()
                      : selectedPeriod == "Weekly"
                          ? WeeklyChart(data: mockWeeklyData)
                          : MonthlyChart(data: mockMonthlyData),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDropdown({
    required String label,
    required String value,
    required List<String> options,
    required void Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              dropdownColor: const Color(0xFF2C5364),
              style: const TextStyle(color: Colors.white),
              value: value,
              isExpanded: true,
              iconEnabledColor: Colors.white,
              items: options
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
