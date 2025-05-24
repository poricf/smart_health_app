import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeeklyChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const WeeklyChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final spots = data.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), (e.value['value'] as num).toDouble());
    }).toList();

    return LineChart(
      LineChartData(
        minX: 0,
        maxX: 6,
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
                final index = value.toInt();
                if (index >= 0 && index < data.length) {
                  return Text(
                    data[index]['day'],
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
            color: Colors.cyanAccent,
            barWidth: 3,
            dotData: FlDotData(show: true),
          )
        ],
      ),
    );
  }
}
