import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/forex/widgets/label.dart';

class ForexGraph extends StatefulWidget {
  final List<ForexModel> timeline;

  const ForexGraph({
    @required this.timeline,
  }) : assert(timeline != null);

  @override
  _ForexGraphState createState() => _ForexGraphState();
}

class _ForexGraphState extends State<ForexGraph> {
  String _getXTitle(double value) {
    int index = value.toInt();
    DateFormat formatter = DateFormat('MMMd');
    return formatter.format(widget.timeline[index].addedDate);
  }

  String _getYTitle(double value) {
    int index = value.toInt();
    var data = widget.timeline[index];
    return '${(data.buying + data.selling) / 2}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Flexible(
          child: Text(
            widget.timeline?.first?.currency ?? 'Forex',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          'Updated: ${widget.timeline?.last?.formattedDate(widget.timeline?.last?.date) ?? DateFormat('dd MMM, yyyy').format(DateTime.now())}',
          style: Theme.of(context).textTheme.caption,
        ),
        const SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: SizedBox(width: double.infinity, child: _buildGraph()),
        ),
        _buildLabelRow(),
        const SizedBox(height: 20.0),
        const Divider(height: 8.0),
      ],
    );
  }

  Widget _buildLabelRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Label(text: 'Sell', color: Colors.green),
        const SizedBox(width: 16.0),
        Label(text: 'Buy', color: Colors.red),
      ],
    );
  }

  LineChart _buildGraph() {
    final double labelSize = 40.0;
    final double maxX = (widget.timeline.length.toDouble() - 1.0).toDouble();
    final double maxY =
        widget.timeline.map((e) => e.selling).reduce(math.max).toDouble();
    final double minY =
        widget.timeline.map((e) => e.buying).reduce(math.min).toDouble();
    final double verticalInterval = (maxX ~/ 4).toDouble();
    final double horizontalInterval = ((maxY - minY) / 4.0);
    final List<double> xValues = widget.timeline
        .map((data) => widget.timeline.indexOf(data).toDouble())
        .toList();

    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(
          handleBuiltInTouches: true,
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: Theme.of(context).cardColor,
            fitInsideHorizontally: true,
          ),
        ),
        minX: 0,
        maxX: maxX,
        minY: minY,
        maxY: maxY,
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          horizontalInterval: horizontalInterval,
          drawVerticalLine: true,
          verticalInterval: verticalInterval,
        ),
        titlesData: FlTitlesData(
          bottomTitles: SideTitles(
            showTitles: true,
            margin: 12.0,
            interval: verticalInterval,
            reservedSize: labelSize,
            textStyle: Theme.of(context).textTheme.caption,
            getTitles: _getXTitle,
          ),
          leftTitles: SideTitles(
            showTitles: true,
            margin: 8.0,
            interval: horizontalInterval,
            reservedSize: labelSize,
            textStyle: Theme.of(context).textTheme.caption,
            getTitles: (value) => '${value.toStringAsFixed(2)}',
          ),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          _buildLineData(
            xValues: xValues,
            yValues: widget.timeline.map((data) => data.buying).toList(),
            color: Colors.green,
          ),
          _buildLineData(
            xValues: xValues,
            yValues: widget.timeline.map((data) => data.selling).toList(),
            color: Colors.red,
          ),
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
      isCurved: true,
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
