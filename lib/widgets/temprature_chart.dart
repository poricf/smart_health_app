import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TemperatureChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const TemperatureChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final bars =
        data
            .map(
              (e) => BarChartGroupData(
                x: e['day'],
                barRods: [
                  BarChartRodData(
                    toY: (e['value'] as num).toDouble(),
                    color: Colors.orange,
                    width: 14,
                  ),
                ],
              ),
            )
            .toList();

    return BarChart(
      BarChartData(
        maxY: 42,
        barGroups: bars,
        gridData: FlGridData(show: true),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(show: false),
      ),
    );
  }
}
