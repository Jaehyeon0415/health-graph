// import 'dart:ui' as ui;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fl_chart/fl_chart.dart';

import 'package:health_graph/enum/data_type.dart';
import 'package:health_graph/model/health_data.dart';
import 'package:health_graph/util/datetime_extension.dart';
import 'package:health_graph/widget/custom_dot.dart';

class HealthGraphPage extends StatefulWidget {
  const HealthGraphPage({super.key});

  @override
  State<HealthGraphPage> createState() => _HealthGraphPageState();
}

class _HealthGraphPageState extends State<HealthGraphPage> {
  late final TextEditingController targetMinController;
  late final TextEditingController targetMaxController;

  final Color lineColor = Colors.cyanAccent.shade700;
  final Color aboveLineColor = Colors.yellow.shade700;
  final Color belowLineColor = Colors.red.shade200;
  final Color targetAreaColor = Colors.lightBlue.shade100.withValues(alpha: 0.3);

  // ui.Image? lunchIcon;
  // ui.Image? nightIcon;

  // 혈당 목표 범위
  int targetMinY = 100;
  int targetMaxY = 130;

  List<HealthData> healthDataList = [];
  LineBarSpot? selectedData;

  double? maxY;

  @override
  void initState() {
    super.initState();
    loadJson();
    // loadIcons();

    targetMinController = TextEditingController();
    targetMaxController = TextEditingController();
  }

  @override
  void dispose() {
    targetMinController.dispose();
    targetMaxController.dispose();
    super.dispose();
  }

  /// JSON 파일 로드
  Future<void> loadJson() async {
    String data = await rootBundle.loadString('assets/data.json');
    setState(() {
      healthDataList = (jsonDecode(data) as List<dynamic>).map((e) => HealthData.fromJson(e)).toList();
      maxY = getMaxYRound(healthDataList);
    });
  }

  // Future<void> loadIcons() async {
  //   lunchIcon = await resizeImage('assets/ic_lunch.png');
  //   nightIcon = await resizeImage('assets/ic_night.png');
  //   setState(() {});
  // }

  // Future<ui.Image> resizeImage(String assetPath, {int? targetWidth, int? targetHeight}) async {
  //   final data = await rootBundle.load(assetPath);
  //   final Uint8List bytes = data.buffer.asUint8List();
  //   final ui.Codec codec = await ui.instantiateImageCodec(
  //     bytes,
  //     targetWidth: targetWidth,
  //     targetHeight: targetHeight,
  //   );

  //   final ui.FrameInfo frameInfo = await codec.getNextFrame();
  //   return frameInfo.image;
  // }

  DataType getDataType(HealthData data, double targetMin, double targetMax) => switch (data.y.toDouble()) {
    double y when y < targetMin  => DataType.below,
    double y when y > targetMax  => DataType.above,
    _ => DataType.normal,
  };

  void onSpotSelected(LineTouchResponse response) {
    final TouchLineBarSpot spot = response.lineBarSpots!.first;
    setState(() {
      selectedData = spot;
    });
  }

  double getMaxYRound(List<HealthData> dataList) {
    double maxY = dataList.map((e) => e.y).reduce((value, element) => value > element ? value : element).toDouble();
    // 50 단위로 올림
    return (maxY / 50).ceil() * 50 + 1;
  }

  Color getColorByTargetY(double y) => switch (y) {
    double y when y < targetMinY  => belowLineColor,
    double y when y > targetMaxY  => aboveLineColor,
    _ => lineColor,
  };

  Color getColorByDataType(DataType type) => switch (type) {
    .below  => belowLineColor,
    .above  => aboveLineColor,
    _ => lineColor,
  };


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                  child: Column(
                    spacing: 12,
                    children: [
                      Text(
                        '설정 목표 혈당 / ($targetMinY) - ($targetMaxY)',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              key: const ValueKey('target-min-y-textfield'),
                              controller: targetMinController,
                              keyboardType: TextInputType.number,
                              autovalidateMode: AutovalidateMode.onUnfocus,
                              validator: (value) {
                                if (value == null) return null;
                                int? number = int.tryParse(value);
                                if (number == null) return '정확한 숫자를 입력해 주세요.';
                                if (number < 0) return '0보다 작을 수 없습니다.';
                                // if (number > targetMaxY) return '최대값보다 높을 수 없습니다.';
                                return null;
                              },
                            ),
                          ),
                          Text(
                            ' - ',
                            style: TextStyle(fontSize: 18),
                          ),
                          Expanded(
                            child: TextFormField(
                              key: const ValueKey('target-max-y-textfield'),
                              controller: targetMaxController,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null) return null;
                                int? number = int.tryParse(value);
                                if (number == null) return '정확한 숫자를 입력해 주세요.';
                                if (number < 0) return '0보다 작을 수 없습니다.';
                                // if (number > targetMaxY) return '최대값보다 높을 수 없습니다.';
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                  
                      TextButton(
                        onPressed: () {
                          int? targetMin = int.tryParse(targetMinController.text);
                          int? targetMax = int.tryParse(targetMaxController.text);
                          if (targetMin == null || targetMax == null) return;
                          if (targetMin > targetMax) return; // min은 max보다 클 수 없습니다.

                          setState(() {
                            targetMinY = targetMin;
                            targetMaxY = targetMax;
                          });
                          loadJson();
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.blue.shade400)
                        ),
                        child: Text(
                          '설정 저장하기',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // MARK: 그래프
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height / 3,
                      ),
                      child: LineChart(
                        transformationConfig: FlTransformationConfig(
                          scaleAxis: FlScaleAxis.horizontal,
                          minScale: 1,
                          maxScale: 25,
                        ),
                        duration: Duration.zero,
                        LineChartData(
                          maxY: maxY,
                          minY: 0,
                          // 혈당 정상 범위
                          rangeAnnotations: RangeAnnotations(
                            horizontalRangeAnnotations: [
                              HorizontalRangeAnnotation(
                                y1: targetMinY.toDouble(),
                                y2: targetMaxY.toDouble(),
                                color: targetAreaColor,
                              ),
                            ],
                          ),
                          gridData: FlGridData(
                            show: true,
                            horizontalInterval: 50,
                            drawVerticalLine: false,
                            getDrawingHorizontalLine: (value) => FlLine(
                              color: Colors.grey.shade200,
                              strokeWidth: 2,
                            ),
                          ),
                          lineTouchData: LineTouchData(
                            touchCallback: (FlTouchEvent event, LineTouchResponse? touchResponse) {
                              if (touchResponse == null || touchResponse.lineBarSpots == null) return;
                              onSpotSelected(touchResponse);
                            },
                            handleBuiltInTouches: true,
                            getTouchedSpotIndicator: (barData, spotIndexes) {
                              return spotIndexes.map((index) {
                                final HealthData data = healthDataList[index];
                                final Color color = getColorByTargetY(data.y.toDouble());
                                return TouchedSpotIndicatorData(
                                  FlLine(
                                    color: color,
                                    strokeWidth: 4,
                                    dashArray: [6, 4],
                                  ),
                                  FlDotData(
                                    show: true,
                                    getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                                      radius: 4,
                                      color: Colors.white,
                                      strokeWidth: 5,
                                      strokeColor: color,
                                    ),
                                  ),
                                );
                              }).toList();
                            },
                            // MARK: 툴팁
                            touchTooltipData: LineTouchTooltipData(
                              tooltipBorderRadius: BorderRadius.circular(20),
                              showOnTopOfTheChartBoxArea: true,
                              getTooltipColor: (LineBarSpot touchedSpot) => getColorByTargetY(touchedSpot.y),
                              getTooltipItems: (touchedSpots) {
                                return touchedSpots.map((spot) {
                                  final dateTime = DateTime.fromMillisecondsSinceEpoch(spot.x.toInt());
                                  return LineTooltipItem(
                                    '${spot.y.toInt()}',
                                    const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: ' mg/dL\n',
                                        style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                      ),
                                      TextSpan(
                                        text: dateTime.toKRTimeString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList();
                              },
                            ),
                            getTouchLineEnd: (barData, spotIndex) => double.infinity,
                          ),
                          showingTooltipIndicators: [
                            if (selectedData != null) 
                              ShowingTooltipIndicators([
                                selectedData!,
                              ]),
                          ],
                          lineBarsData: [
                            LineChartBarData(
                              spots: healthDataList.map((e) => FlSpot(e.dt.millisecondsSinceEpoch.toDouble(), e.y.toDouble())).toList(),
                              barWidth: 4,
                              isCurved: true,
                              isStrokeCapRound: true,
                              isStrokeJoinRound: true,
                              curveSmoothness: 0.6,
                              dotData: FlDotData(
                                show: true,
                                checkToShowDot: (spot, barData) {
                                  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(spot.x.toInt());
                                  return dateTime.minute == 0 && dateTime.second == 0 && dateTime.hour % 6 == 0
                                    && (dateTime.hour == 12 || dateTime.hour == 22);
                                },
                                getDotPainter: (spot, percent, barData, index) {
                                  // TODO: 오후 12시, 오후 10시 아이콘 오버레이
                                  // DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(spot.x.toInt());
                                  // bool isLunch = dateTime.hour == 12;
                            
                                  return CustomDotPainter(
                                    radius: 16,
                                    // image: isLunch ? lunchIcon : nightIcon,
                                  );
                                },
                              ),
                              showingIndicators: [
                                if (selectedData != null) ...[
                                  selectedData!.spotIndex,
                                ],
                                100,
                              ],
                              color: lineColor,
                              // TODO: 목표 범위에 따른 그라데이션 색상 적용
                              // gradient: LinearGradient(),
                              belowBarData: BarAreaData(
                                show: true,
                                cutOffY: targetMaxY.toDouble(),
                                applyCutOffY: true,
                                gradient: LinearGradient(
                                  colors: [
                                    aboveLineColor,
                                    aboveLineColor.withValues(alpha: 0.1),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              aboveBarData: BarAreaData(
                                show: true,
                                cutOffY: targetMinY.toDouble(),
                                applyCutOffY: true,
                                gradient: LinearGradient(
                                  colors: [
                                    belowLineColor,
                                    belowLineColor.withValues(alpha: 0.1),
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                            ),
                          ],
                          titlesData: FlTitlesData(
                            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            // MARK: Y축 가이드 문구
                            rightTitles: AxisTitles(
                              drawBelowEverything: true,
                              sideTitles: SideTitles(
                                showTitles: true,
                                minIncluded: false,
                                maxIncluded: false,
                                reservedSize: 40,
                                interval: 50,
                                getTitlesWidget: (value, meta) {
                                  return SideTitleWidget(
                                    meta: meta,
                                    child: Text(
                                      value.toInt().toString(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey.shade400,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            // MARK: X축 가이드 문구
                            bottomTitles: AxisTitles(
                              drawBelowEverything: true,
                              sideTitles: SideTitles(
                                showTitles: true,
                                maxIncluded: false,
                                minIncluded: false,
                                reservedSize: 50,
                                interval: 100000,
                                getTitlesWidget: (value, meta) {
                                  final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(value.toInt());
                                  // 정각 & 6시간 간격인지 확인
                                  bool isExactHour = dateTime.minute == 0 && dateTime.second == 0 && dateTime.hour % 6 == 0;
                            
                                  return isExactHour
                                    ? SideTitleWidget(
                                        meta: meta,
                                        child: Text(
                                          dateTime.toKRHourString(),
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey.shade400,
                                          ),
                                        ),
                                      )
                                  : const SizedBox.shrink();
                                },
                              ),
                            )
                          ),
                          borderData: FlBorderData(
                            show: true,
                            border: Border(bottom: BorderSide(color: Colors.grey.shade200, width: 2)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}