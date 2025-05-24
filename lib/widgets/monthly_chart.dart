import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MonthlyChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const MonthlyChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final spots = data.asMap().entries.map((e) {
      return FlSpot((e.key + 1).toDouble(), (e.value['value'] as num).toDouble());
    }).toList();

    return LineChart(
      LineChartData(
        minX: 1,
        maxX: 30,
        minY: 0,
        maxY: spots.map((e) => e.y).reduce((a, b) => a > b ? a : b) + 10,
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                // Only show a few day labels to reduce clutter
                if (value % 5 == 0) {
                  return Text(
                    value.toInt().toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  );
                }
                return const Text('');
              },
            ),
          ),
        ),
        gridData: FlGridData(show: true),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: Colors.orangeAccent,
            barWidth: 2,
            dotData: FlDotData(show: false),
          )
        ],
      ),
    );
  }
}
