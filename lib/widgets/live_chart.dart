import 'dart:async';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LiveChart extends StatefulWidget {
  const LiveChart({super.key});

  @override
  State<LiveChart> createState() => _LiveChartState();
}

class _LiveChartState extends State<LiveChart> {
  final List<FlSpot> _dataPoints = [];
  final int _maxLength = 20;
  late Timer _timer;
  int _xValue = 0;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _addMockData());
  }

  void _addMockData() {
    final newY = 95 + _random.nextDouble() * 5; // range 95-100
    if (_dataPoints.length >= _maxLength) {
      _dataPoints.removeAt(0);
    }
    _dataPoints.add(FlSpot(_xValue.toDouble(), newY));
    _xValue++;

    setState(() {});
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minY: 90,
        maxY: 105,
        titlesData: FlTitlesData(show: false),
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        lineTouchData: LineTouchData(enabled: false),
        lineBarsData: [
          LineChartBarData(
            isCurved: true,
            spots: _dataPoints,
            color: Colors.amberAccent,
            barWidth: 3,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.amberAccent.withOpacity(0.2),
            ),
          ),
        ],
      ),
    );
  }
}
