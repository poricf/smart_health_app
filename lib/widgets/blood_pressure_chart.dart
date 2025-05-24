import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BloodPressureChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const BloodPressureChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final groups =
        data.map((e) {
          final int x = e['day'];
          final int sys = e['systolic'];
          final int dia = e['diastolic'];

          return BarChartGroupData(
            x: x,
            barRods: [
              BarChartRodData(
                toY: sys.toDouble(),
                color: Colors.purpleAccent,
                width: 8,
              ),
              BarChartRodData(
                toY: dia.toDouble(),
                color: Colors.deepPurple,
                width: 8,
              ),
            ],
          );
        }).toList();

    return BarChart(
      BarChartData(
        maxY: 160,
        barGroups: groups,
        gridData: FlGridData(show: true),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(show: false),
        barTouchData: BarTouchData(enabled: false),
      ),
    );
  }
}
