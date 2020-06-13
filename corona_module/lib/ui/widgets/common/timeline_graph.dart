import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:fl_chart/fl_chart.dart';

import '../../../core/models/timeline_data.dart';
import '../../styles/styles.dart';
import 'fade_animator.dart';
import 'label.dart';

class TimelineGraph extends StatefulWidget {
  final String title;
  final List<TimelineData> timeline;

  const TimelineGraph({
    @required this.title,
    @required this.timeline,
  })  : assert(title != null),
        assert(timeline != null);

  @override
  _TimelineGraphState createState() => _TimelineGraphState();
}

class _TimelineGraphState extends State<TimelineGraph> {
  RangeValues sliderValues;

  @override
  void initState() {
    super.initState();
    sliderValues = RangeValues(0.0, widget.timeline.length.toDouble() - 1.0);
  }

  String _getXTitle(double value) {
    int index = value.toInt();
    List<String> dateElements = widget.timeline[index].date.split('-');

    // Pad month and day with leading zero
    dateElements[1] = dateElements[1].padLeft(2, '0');
    dateElements[2] = dateElements[2].padLeft(2, '0');

    DateTime date = DateTime.parse(dateElements.join());
    DateFormat formatter = DateFormat('MMMd');
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return FadeAnimator(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Divider(height: 24.0),
          Flexible(
            child: Text(
              widget.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.mediumLight,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            'spread over time',
            style: AppTextStyles.smallLight,
          ),
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: _buildGraph(),
          ),
          _buildLabelRow(),
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                valueIndicatorColor: AppColors.primary.withOpacity(0.5),
                valueIndicatorTextStyle: AppTextStyles.smallLight,
              ),
              child: RangeSlider(
                min: 0.0,
                max: widget.timeline.length.toDouble() - 1.0,
                divisions: widget.timeline.length,
                activeColor: AppColors.primary,
                inactiveColor: AppColors.primary.withOpacity(0.4),
                labels: RangeLabels(
                  _getXTitle(sliderValues.start),
                  _getXTitle(sliderValues.end),
                ),
                values: sliderValues,
                onChanged: (values) {
                  if (values.end - values.start > 10.0)
                    setState(() {
                      sliderValues = values;
                    });
                },
              ),
            ),
          ),
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
        Label(text: 'Confirmed', color: Colors.blue),
        const SizedBox(width: 16.0),
        Label(text: 'Recovered', color: Colors.green),
        const SizedBox(width: 16.0),
        Label(text: 'Deaths', color: Colors.red),
      ],
    );
  }

  LineChart _buildGraph() {
    final double labelSize = 40.0;
    final double maxY = widget.timeline.map((e) => e.confirmed).reduce(math.max).toDouble();
    final double verticalInterval = ((sliderValues.end - sliderValues.start) ~/ 4).toDouble();
    final double horizontalInterval = (maxY ~/ 5).toDouble();
    final List<double> xValues =
        widget.timeline.map((data) => widget.timeline.indexOf(data).toDouble()).toList();

    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(
          handleBuiltInTouches: true,
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: AppColors.background.withOpacity(0.7),
            fitInsideHorizontally: true,
          ),
        ),
        minX: sliderValues.start,
        maxX: sliderValues.end,
        minY: 0.0,
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
            textStyle: AppTextStyles.extraSmallLight,
            getTitles: _getXTitle,
          ),
          leftTitles: SideTitles(
            showTitles: true,
            margin: 8.0,
            interval: horizontalInterval,
            reservedSize: labelSize,
            textStyle: AppTextStyles.extraSmallLight,
            getTitles: (value) => '${value.round()}',
          ),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          _buildLineData(
            xValues: xValues,
            yValues: widget.timeline.map((data) => data.confirmed.toDouble()).toList(),
            color: Colors.blue,
          ),
          _buildLineData(
            xValues: xValues,
            yValues: widget.timeline.map((data) => data.recovered.toDouble()).toList(),
            color: Colors.green,
          ),
          _buildLineData(
            xValues: xValues,
            yValues: widget.timeline.map((data) => data.deaths.toDouble()).toList(),
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
