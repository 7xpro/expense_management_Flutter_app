import "package:flutter/material.dart";
import "package:fl_chart/fl_chart.dart";

class InsightPageChart extends StatelessWidget {
  final Map<String, double> dailySpends;

  const InsightPageChart({
    super.key,
    this.dailySpends = const {
      'Mon': 1200,
      'Tue': 800,
      'Wed': 2100,
      'Thu': 500,
      'Fri': 1750,
      'Sat': 3000,
      'Sun': 950,
    },
  });

  @override
  Widget build(BuildContext context) {
    final days = dailySpends.keys.toList();
    final maxY = dailySpends.values.reduce((a, b) => a > b ? a : b);

    return Container(
      height: 260,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(8, 20, 16, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: BarChart(
        BarChartData(
          maxY: maxY * 1.25, // headroom above tallest bar
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: maxY / 4,
            getDrawingHorizontalLine: (_) => FlLine(
              color: Colors.grey.shade200,
              strokeWidth: 1,
            ),
          ),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            // Day labels at the bottom
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < 0 || index >= days.length) return const SizedBox();
                  return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      days[index],
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
            // Rupee amounts on the left
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 48,
                interval: maxY / 4,
                getTitlesWidget: (value, meta) {
                  return Text(
                    '₹${value.toInt()}',
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  );
                },
              ),
            ),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          barGroups: List.generate(days.length, (i) {
            final spend = dailySpends[days[i]]!;
            return BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: spend,
                  width: 16,
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.blue,
                ),
              ],
            );
          }),
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  '${days[group.x]}\n₹${rod.toY.toStringAsFixed(0)}',
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}