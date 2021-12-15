import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:vanelliapp/app/shared/size_config.dart';

class BarChartEidget extends StatelessWidget {
  const BarChartEidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getHeight(context) * .5,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Colors.grey[50],
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
          child: BarChart(
            BarChartData(
                borderData: buildFlBorderData(),
                alignment: BarChartAlignment.center,
                maxY: 40,
                minY: 0,
                groupsSpace: 2,
                barTouchData: BarTouchData(enabled: true),
                titlesData: buildFlTitlesData(),
                backgroundColor: Colors.white,
                gridData: FlGridData(
                  show: false,
                ),
                barGroups: BarData.barData
                    .map(
                      (data) => BarChartGroupData(
                        x: data.id,
                        barRods: [
                          BarChartRodData(
                            y: data.y,
                            width: 26,
                            colors: [data.color],
                            backDrawRodData: BackgroundBarChartRodData(
                              colors: [const Color(0xff0097a7)],
                              y: 40,
                              show: true,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(1),
                              topRight: Radius.circular(1),
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
                rangeAnnotations:
                    RangeAnnotations(horizontalRangeAnnotations: [])),

            swapAnimationDuration:
                const Duration(milliseconds: 150), // Optional
            swapAnimationCurve: Curves.linear,
          ),
        ),
      ),
    );
  }

  FlTitlesData buildFlTitlesData() {
    return FlTitlesData(
      topTitles: BarTitles.noTitle(),
      bottomTitles: BarTitles.getTopBottomTitles(),
      leftTitles: BarTitles.getSideTitles(),
      rightTitles: BarTitles.noTitle(),
    );
  }

  FlBorderData buildFlBorderData() {
    return FlBorderData(
      border: const Border(
        top: BorderSide.none,
        right: BorderSide.none,
        left: BorderSide(width: 0.5),
        bottom: BorderSide(width: 0.5),
      ),
    );
  }
}

class BarData {
  static int interval = 1;
  static Color colorBar = Color(0xff00e5ff);

  static List<Data> barData = [
    Data(
      id: 1,
      name: 'Jan',
      y: 23,
      color: colorBar,
    ),
    Data(
      name: 'Fev',
      id: 2,
      y: 18,
      color: colorBar,
    ),
    Data(
      name: 'Mar',
      id: 3,
      y: 11,
      color: colorBar,
    ),
    Data(
      name: 'Abr',
      id: 4,
      y: 10,
      color: colorBar,
    ),
    Data(
      name: 'Mai',
      id: 5,
      y: 13,
      color: colorBar,
    ),
    Data(
      name: 'Jun',
      id: 6,
      y: 10,
      color: colorBar,
    ),
    Data(
      name: 'Jul',
      id: 7,
      y: 5,
      color: colorBar,
    ),
    Data(
      name: 'Ago',
      id: 8,
      y: 19,
      color: colorBar,
    ),
    Data(
      name: 'Set',
      id: 9,
      y: 15,
      color: colorBar,
    ),
    Data(
      name: 'Out',
      id: 10,
      y: 19,
      color: colorBar,
    ),
    Data(
      name: 'Nov',
      id: 11,
      y: 20,
      color: colorBar,
    ),
    Data(
      name: 'Dez',
      id: 12,
      y: 25,
      color: colorBar,
    ),
  ];
}

class BarTitles {
  static SideTitles noTitle() => SideTitles(
        showTitles: false,
      );

  static SideTitles getTopBottomTitles() => SideTitles(
        showTitles: true,
        getTextStyles: (value, BarData) =>
            const TextStyle(color: Colors.teal, fontSize: 10),
        margin: 10,
        getTitles: (double id) => BarData.barData
            .firstWhere((element) => element.id == id.toInt())
            .name,
      );

  static SideTitles getSideTitles() => SideTitles(
        showTitles: true,
        getTextStyles: (value, BarData) =>
            const TextStyle(color: Colors.teal, fontSize: 10),
        // rotateAngle: 90,
        interval: 5,
        margin: 10,

        // reservedSize: 30,
        getTitles: (double value) => '${value.toInt()}',
      );
}

class Data {
  final int id;
  final String name;
  final double y;
  final Color color;
  Data({
    required this.id,
    required this.name,
    required this.y,
    required this.color,
  });

  @override
  String toString() {
    return 'Data(id: $id, name: $name, y: $y, color: $color)';
  }
}
