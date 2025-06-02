import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HeartRateChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const HeartRateChart({super.key, required this.data});
  // heart rate chart
  @override
  Widget build(BuildContext context) {
    final spots =
        data
            .map(
              (e) => FlSpot(
                (e['day'] as int).toDouble(),
                (e['value'] as num).toDouble(),
              ),
            )
            .toList();

    return LineChart(
      LineChartData(
        minY: 50,
        maxY: 130,
        lineBarsData: [
          LineChartBarData(
            isCurved: true,
            spots: spots,
            color: Colors.redAccent,
            barWidth: 3,
            belowBarData: BarAreaData(show: false),
            dotData: FlDotData(show: false),
          ),
        ],
        gridData: FlGridData(show: true),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(show: false),
      ),
    );
  }
}
