import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tomorrow_diary/controllers/diary_controller.dart';
import 'package:tomorrow_diary/models/data_model.dart';
import 'package:tomorrow_diary/utils/utils.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({Key? key}) : super(key: key);

  @override
  _AnalysisScreenState createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  int touchedIndex = -1;
  DiaryController d = Get.find();

  @override
  void initState() {
    DiaryController d = Get.find();
    d.findDataByMonth(2021, 10);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int daysCount = CalendarUtil.daysCount(2021, 10);
    int tmrCount = 0; // only tmr written
    int tyCount = 0; // only ty written
    int todoCount = 0;
    int diaryCompleted = 0; // both written
    for (var element in d.analysisData) {
      bool isTmrDiaryWritten = false;
      bool isTyDiaryWritten = false;
      if (element.tmrDiary != null && !element.tmrDiary!.isEmpty()) {
        isTmrDiaryWritten = true;
      }
      if (element.tyDiary != null && !element.tyDiary!.isEmpty()) {
        isTyDiaryWritten = true;
      }
      if (element.todoList != null && element.todoList!.isNotEmpty) {
        todoCount++;
      }
      if (isTmrDiaryWritten && isTyDiaryWritten) {
        diaryCompleted++;
      } else if (isTmrDiaryWritten) {
        tmrCount++;
      } else if (isTyDiaryWritten) {
        tyCount++;
      }
    }

    return FutureBuilder<List<DataModel>>(
      future: d.findDataByMonth(2021, 10),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // data가 있을 때
          print(snapshot.data); // question
          print(snapshot.error); // null
          return Scaffold(
            backgroundColor: TdColor.black,
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(CupertinoIcons.back)),
            ),
            body: SafeArea(
              child: ListView(
                children: [
                  AspectRatio(
                    aspectRatio: 13 / 10,
                    child: Card(
                      color: TdColor.gray,
                      child: Row(
                        children: <Widget>[
                          const SizedBox(
                            height: 18,
                          ),
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: PieChart(
                                PieChartData(
                                  pieTouchData: PieTouchData(
                                    touchCallback:
                                        (FlTouchEvent event, pieTouchResponse) {
                                      setState(
                                        () {
                                          if (!event
                                                  .isInterestedForInteractions ||
                                              pieTouchResponse == null ||
                                              pieTouchResponse.touchedSection ==
                                                  null) {
                                            touchedIndex = -1;
                                            return;
                                          }
                                          touchedIndex = pieTouchResponse
                                              .touchedSection!
                                              .touchedSectionIndex;
                                        },
                                      );
                                    },
                                  ),
                                  borderData: FlBorderData(
                                    show: false,
                                  ),
                                  sectionsSpace: 0,
                                  centerSpaceRadius: 40,
                                  sections: showingSummrySections(
                                      daysCount,
                                      tmrCount,
                                      tyCount,
                                      todoCount,
                                      diaryCompleted),
                                ),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const <Widget>[
                              Indicator(
                                color: Color(0xff845bef),
                                text: '모두 완성',
                                isSquare: true,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Indicator(
                                color: Color(0xfff8b250),
                                text: '내일의 일기만 완성',
                                isSquare: true,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Indicator(
                                color: Color(0xff0293ee),
                                text: '오늘의 일기만 완성',
                                isSquare: true,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Indicator(
                                color: Color(0xff13d38e),
                                text: '둘 다 미완성',
                                isSquare: true,
                              ),
                              SizedBox(
                                height: 18,
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 28,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          print(snapshot.data); // null
          print(snapshot.error); // 에러메세지 ex) 사용자 정보를 확인할 수 없습니다.
          return Text("데이터 로딩에 실패하였습니다. 아..");
        } else {
          return Text("로딩...");
        }
      },
    );
  }

  //모든 데이터 요약 차트
  List<PieChartSectionData> showingSummrySections(int daysCount, int tmrCount,
      int tyCount, int todoCount, int diaryCompleted) {
    double _allCompletedPercent = diaryCompleted * 100 / daysCount;
    double _tmrPercent = tmrCount * 100 / daysCount;
    double _tyPercent = tyCount * 100 / daysCount;
    double _noCompletedPercent =
        (daysCount - diaryCompleted - tmrCount - tyCount) * 100 / daysCount;
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: _allCompletedPercent,
            title: '${_allCompletedPercent ~/ 1}%',
            radius: radius,
            titleStyle: GoogleFonts.notoSans(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: TdColor.white,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: _tmrPercent,
            title: '${_tmrPercent ~/ 1}%',
            radius: radius,
            titleStyle: GoogleFonts.notoSans(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: TdColor.white,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: _tyPercent,
            title: '${_tyPercent ~/ 1}%',
            radius: radius,
            titleStyle: GoogleFonts.notoSans(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: TdColor.white,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: _noCompletedPercent,
            title: '${_noCompletedPercent ~/ 1}%',
            radius: radius,
            titleStyle: GoogleFonts.notoSans(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: TdColor.white,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;

  const Indicator({
    Key? key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor = TdColor.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
        )
      ],
    );
  }
}
