import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LowResponses extends StatefulWidget {
  final double width;
  const LowResponses({
    super.key,
    required this.width,
  });

  @override
  State<LowResponses> createState() => _LowResponsesState();
}

class _LowResponsesState extends State<LowResponses> {
  final ScrollController _horizontalController = ScrollController();

  @override
  void dispose() {
    _horizontalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<BarChartGroupData> barData = [
      BarChartGroupData(
          x: 0, barRods: [BarChartRodData(toY: 5, color: Color(0xFF064089))]),
      BarChartGroupData(
          x: 0, barRods: [BarChartRodData(toY: 5, color: Color(0xFF064089))]),
      BarChartGroupData(
          x: 0, barRods: [BarChartRodData(toY: 5, color: Color(0xFF064089))]),
      BarChartGroupData(
          x: 0, barRods: [BarChartRodData(toY: 5, color: Color(0xFF064089))]),
      BarChartGroupData(
          x: 0, barRods: [BarChartRodData(toY: 5, color: Color(0xFF064089))]),
      BarChartGroupData(
          x: 0, barRods: [BarChartRodData(toY: 5, color: Color(0xFF064089))]),
      BarChartGroupData(
          x: 0, barRods: [BarChartRodData(toY: 5, color: Color(0xFF064089))]),
    ];

    double barWidth = 300;
    double chartWidth = barData.length * barWidth.toDouble();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
            child: SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Units with Low Responses",
                    style: TextStyle(
                      color: Color(0xFF064089),
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    height: 23,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                        side: BorderSide(
                          color: Color(0xFF1E1E1E),
                          width: 0.9,
                        ),
                        backgroundColor: Color(0xFFE1E2E6),
                        padding: EdgeInsets.zero,
                      ),
                      child: Text(
                        "View Report",
                        style: TextStyle(
                          color: Color(0xFF1E1E1E),
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFFCFD8E5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(3, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Scrollbar(
                controller: _horizontalController,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  controller: _horizontalController,
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    height: 260,
                    width: chartWidth,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: 20,
                        barGroups: barData,
                        titlesData: FlTitlesData(
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 25,
                              interval: 5,
                              getTitlesWidget: (value, meta) {
                                return value % 5 == 0
                                    ? Text(
                                        '${value.toInt()}',
                                        style: const TextStyle(
                                          color: Color(0xFF064089),
                                          fontSize: 12,
                                        ),
                                      )
                                    : Container();
                              },
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 60,
                              interval: 1,
                              getTitlesWidget: (value, meta) {
                                return FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    'College of Computer Studies',
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        gridData: FlGridData(
                          show: true,
                          checkToShowHorizontalLine: (value) => value % 5 == 0,
                          getDrawingHorizontalLine: (value) => FlLine(
                            color: Color(0xFF949699),
                            strokeWidth: 2,
                          ),
                          drawVerticalLine: false,
                        ),
                        borderData: FlBorderData(show: false),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
