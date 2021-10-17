import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tomorrow_diary/controllers/gallery_controller.dart';
import 'package:tomorrow_diary/utils/utils.dart';

class AnalysisEmoScreen extends StatefulWidget {
  const AnalysisEmoScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    Get.put(GalleryController());
    return AnalysisEmoScreenState();
  }
}

class AnalysisEmoScreenState extends State<AnalysisEmoScreen> {
  final Duration animDuration = const Duration(milliseconds: 250);
  GalleryController gc = Get.find();
  int touchedIndex = -1;

  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/tomorrow2.gif'), fit: BoxFit.cover),
          ),
          color: Colors.transparent,
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            icon: Icon(Icons.arrow_back,
                                color: Colors.white, size: 30),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const SizedBox(
                      height: 38,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: BarChart(
                          mainBarData(),
                          swapAnimationDuration: animDuration,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = const Color(0xffC49C48),
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isTouched ? [Color(0xffff7043)] : [barColor],
          width: width,
          borderSide: isTouched
              ? BorderSide(color: Color(0x2e1503), width: 1)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 100,
            colors: [const Color(0x62ffffff)],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(8, (i) {
        double happy = 0.0;
        double sad = 0.0;
        double calm = 0.0;
        double surp = 0.0;
        double fear = 0.0;
        double confused = 0.0;
        double angry = 0.0;
        double disgusted = 0.0;
        double none = 0.0;
        for (var emo in gc.emotion) {
          switch (emo[TYPE]) {
            case HAPPY:
              happy = emo[CONFIDENCE].ceil().toDouble();
              break;
            case SAD:
              sad = emo[CONFIDENCE].ceil().toDouble();
              break;
            case CALM:
              calm = emo[CONFIDENCE].ceil().toDouble();
              break;
            case SURPRISED:
              surp = emo[CONFIDENCE].ceil().toDouble();
              break;
            case FEAR:
              fear = emo[CONFIDENCE].ceil().toDouble();
              break;
            case CONFUSED:
              confused = emo[CONFIDENCE].ceil().toDouble();
              break;
            case ANGRY:
              angry = emo[CONFIDENCE].ceil().toDouble();
              break;
            case DISGUSTED:
              disgusted = emo[CONFIDENCE].ceil().toDouble();
              break;
            default:
              none = 0.0;
          }
        }
        switch (gc.emotion[0][TYPE]) {
        }
        switch (i) {
          case 0:
            return makeGroupData(0, happy, isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, sad, isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, calm, isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, surp, isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, fear, isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, confused, isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, angry, isTouched: i == touchedIndex);
          case 7:
            return makeGroupData(7, disgusted, isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.black87,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String emotion;
              switch (group.x.toInt()) {
                case 0:
                  emotion = 'Happy';
                  break;
                case 1:
                  emotion = 'Sad';
                  break;
                case 2:
                  emotion = 'Calm';
                  break;
                case 3:
                  emotion = 'Surprised';
                  break;
                case 4:
                  emotion = 'Fear';
                  break;
                case 5:
                  emotion = 'Confused';
                  break;
                case 6:
                  emotion = 'Angry';
                  break;
                case 7:
                  emotion = 'Disgusted';
                  break;
                default:
                  throw Error();
              }
              return BarTooltipItem(
                emotion + '\n',
                const TextStyle(
                  color: Color(0xffC0C0C0),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.y - 1).toString(),
                    style: const TextStyle(
                      color: Color(0xffFFD700),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return '행복';
              case 1:
                return '슬픔';
              case 2:
                return '차분한';
              case 3:
                return '놀람';
              case 4:
                return '두려움';
              case 5:
                return '혼란';
              case 6:
                return '화남';
              case 7:
                return '역겨움';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: FlGridData(show: false),
    );
  }
}
