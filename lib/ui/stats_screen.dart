import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/weekly_chart.dart';
import '../widgets/monthly_chart.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mockDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final mockWeekly =
        (int base) => List.generate(
          7,
          (i) => {"day": mockDays[i], "value": base + (i % 5)},
        );
    final mockMonthly =
        (int base) =>
            List.generate(30, (i) => {"day": i + 1, "value": base + (i % 4)});

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Health Stats"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _section("Heart Rate", mockWeekly(75), mockMonthly(73)),
              _section("SpO₂", mockWeekly(96), mockMonthly(95)),
              _section("Temperature", mockWeekly(37), mockMonthly(36)),
              _section("Blood Pressure", mockWeekly(110), mockMonthly(108)),

              const SizedBox(height: 10),

              _glassCard(
                "Step Count",
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _metricTile("Today", "5,830 steps"),
                    _metricTile("Yesterday", "6,120 steps"),
                    _metricTile("Weekly Avg", "5,940 steps"),
                    _metricTile("Goal", "8,000 steps"),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              _glassCard(
                "Sleep Monitoring",
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _metricTile("Total Duration", "7 hr 42 min"),
                    _metricTile("Deep Sleep", "2 hr 15 min"),
                    _metricTile("Light Sleep", "3 hr 50 min"),
                    _metricTile("Awake", "1 hr 37 min"),
                    _metricTile("Sleep Score", "82 / 100"),
                  ],
                ),
              ),
              

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _section(
    String title,
    List<Map<String, dynamic>> weekly,
    List<Map<String, dynamic>> monthly,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _glassCard("Weekly $title", WeeklyChart(data: weekly), height: 200),
        const SizedBox(height: 10),
        _glassCard("Monthly $title", MonthlyChart(data: monthly), height: 200),
        const SizedBox(height: 10),
        _glassCard("$title Analysis", _analysisTile(title, weekly, monthly)),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _glassCard(String title, Widget child, {double? height}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              height != null ? SizedBox(height: height, child: child) : child,
            ],
          ),
        ),
      ),
    );
  }

  Widget _metricTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70)),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _analysisTile(
    String title,
    List<Map<String, dynamic>> weekly,
    List<Map<String, dynamic>> monthly,
  ) {
    double average(List<Map<String, dynamic>> data) =>
        data.map((e) => e['value'] as num).reduce((a, b) => a + b) /
        data.length;

    final weeklyAvg = average(weekly).toStringAsFixed(1);
    final monthlyAvg = average(monthly).toStringAsFixed(1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _metricTile("Weekly Avg", "$weeklyAvg"),
        _metricTile("Monthly Avg", "$monthlyAvg"),
        _metricTile("Status", _getHealthStatus(title, double.parse(weeklyAvg))),
      ],
    );
  }

  String _getHealthStatus(String title, double value) {
    switch (title) {
      case "Heart Rate":
        return value < 60
            ? "Low"
            : value > 100
            ? "High"
            : "Normal";
      case "SpO₂":
        return value < 95 ? "Low" : "Normal";
      case "Temperature":
        return value > 37.5 ? "Fever" : "Normal";
      case "Blood Pressure":
        return value > 130
            ? "High"
            : value < 90
            ? "Low"
            : "Normal";
      default:
        return "Unknown";
    }
  }
}
