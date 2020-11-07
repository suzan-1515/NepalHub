import 'dart:math' as math;

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:samachar_hub/feature_gold/domain/entities/gold_silver_entity.dart';
import 'package:samachar_hub/feature_gold/presentation/ui/gold_silver/widgets/label.dart';
import 'package:samachar_hub/feature_gold/presentation/extensions/gold_silver_extensions.dart';
import 'package:samachar_hub/core/extensions/number_extensions.dart';

class GoldSilverGraph extends StatelessWidget {
  final List<GoldSilverEntity> timeline;

  const GoldSilverGraph({
    @required this.timeline,
  }) : assert(timeline != null);

  String _getXTitle(double value) {
    int index = value.toInt();
    DateFormat formatter = DateFormat('MMMd');
    return formatter.format(timeline[index].publishedAt);
  }

  String _getYTitle(double value) {
    int index = value.toInt();
    var data = timeline[index];
    return '${data.price.formattedString}';
  }

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: Duration(milliseconds: 200),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: Text(
              timeline?.first?.category?.title ?? 'GoldSilver',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Last Updated: ${timeline?.last?.publishedAt?.formattedString ?? DateFormat('dd MMM, yyyy').format(DateTime.now())}',
            style: Theme.of(context).textTheme.caption,
          ),
          const SizedBox(height: 20.0),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: _buildGraph(context),
            ),
          ),
          _buildLabelRow(),
          const SizedBox(height: 20.0),
          const Divider(height: 8.0),
        ],
      ),
    );
  }

  Widget _buildLabelRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Label(text: 'Tola', color: Colors.red),
        // const SizedBox(width: 16.0),
        // const Label(text: 'gms', color: Colors.red),
      ],
    );
  }

  LineChart _buildGraph(BuildContext context) {
    final double labelSize = 40.0;
    final double minX = 0;
    final double maxX = (timeline.length.toDouble() - 1.0).toDouble();
    final double maxY =
        timeline.map((e) => e.price).reduce(math.max).toDouble() + 100;
    final double minY =
        timeline.map((e) => e.price).reduce(math.min).toDouble() - 100;
    final double verticalInterval = ((maxY - minY) ~/ 3).toDouble();
    final double horizontalInterval = (maxX ~/ 5).toDouble();
    final List<double> xValues =
        timeline.map((data) => timeline.indexOf(data).toDouble()).toList();

    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(
          handleBuiltInTouches: true,
          touchTooltipData: LineTouchTooltipData(
              getTooltipItems: (touchedSpots) {
                return touchedSpots
                    .asMap()
                    .map((index, LineBarSpot touchedSpot) {
                      if (touchedSpot == null) {
                        return null;
                      }
                      final TextStyle textStyle = TextStyle(
                        color: touchedSpot.bar.colors[0].withOpacity(1),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      );
                      return MapEntry(
                        index,
                        LineTooltipItem(
                            (index == 0)
                                ? '${_getXTitle(touchedSpot.x)}\nNRs. ${touchedSpot.y.formattedString}'
                                : touchedSpot.y.toString(),
                            textStyle),
                      );
                    })
                    .values
                    .toList();
              },
              tooltipBgColor: Theme.of(context).cardColor,
              fitInsideHorizontally: true,
              fitInsideVertically: true),
        ),
        minX: minX,
        maxX: maxX,
        minY: minY,
        maxY: maxY,
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          horizontalInterval: verticalInterval,
          drawVerticalLine: true,
          verticalInterval: horizontalInterval,
        ),
        titlesData: FlTitlesData(
          bottomTitles: SideTitles(
            showTitles: true,
            margin: 12.0,
            interval: horizontalInterval,
            reservedSize: labelSize,
            textStyle: Theme.of(context).textTheme.caption,
            getTitles: _getXTitle,
          ),
          leftTitles: SideTitles(
            showTitles: true,
            margin: 8.0,
            interval: verticalInterval,
            reservedSize: labelSize + 20,
            textStyle: Theme.of(context).textTheme.caption,
            getTitles: (value) => '${value.formattedString}',
          ),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          _buildLineData(
            xValues: xValues,
            yValues: timeline.map((e) => e.price.toDouble()).toList(),
            color: Colors.red,
          ),
          // _buildLineData(
          //   xValues: timeline
          //       .where((element) => element.unit == 'ten_gram')
          //       .map((data) => timeline.indexOf(data).toDouble())
          //       .toList(),
          //   yValues: timeline
          //       .where((element) => element.unit == 'ten_gram')
          //       .map((data) => data.price)
          //       .toList(),
          //   color: Colors.red,
          // ),
        ],
      ),
    );
  }

  LineChartBarData _buildLineData({
    List<double> xValues,
    List<double> yValues,
    Color color,
  }) {
    return LineChartBarData(
      spots: List<FlSpot>.generate(
        xValues.length,
        (index) => FlSpot(xValues[index], yValues[index]),
      ),
      isCurved: false,
      preventCurveOverShooting: true,
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false),
      colors: [
        color.withOpacity(0.3),
        color.withOpacity(0.7),
        color,
      ],
      colorStops: [0.0, 0.2, 0.6],
      belowBarData: BarAreaData(
        show: true,
        colors: [
          color.withOpacity(0.7),
          color.withOpacity(0.5),
          color.withOpacity(0.3),
          color.withOpacity(0.0),
        ],
        gradientColorStops: [0.0, 0.5, 0.7, 1.0],
      ),
    );
  }
}
