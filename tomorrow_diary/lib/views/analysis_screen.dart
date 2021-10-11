import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:tomorrow_diary/controllers/diary_controller.dart';
import 'package:tomorrow_diary/models/data_model.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';

class AnalysisScreen extends StatefulWidget {
  final selectedYear;
  final selectedMonth;
  const AnalysisScreen(
      {Key? key, required this.selectedYear, required this.selectedMonth})
      : super(key: key);

  @override
  _AnalysisScreenState createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  int touchedIndex = -1;
  DiaryController d = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    d.analysisData.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DataModel>>(
      future: d.analysisData.isEmpty
          ? d.findDataByMonth(widget.selectedYear, widget.selectedMonth)
          : d.getAnalyzedData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // data가 있을 때
          double daysCount = CalendarUtil.daysCount(
                  widget.selectedYear, widget.selectedMonth) /
              1;
          // ---- profile ----
          double totalPercent = 0;

          // ---- summary ----
          double tmrCount = 0; // only tmr written
          double tyCount = 0; // only ty written
          double diaryCompleted = 0; // both written
          Map<String, double> summaryMap;

          // ---- todo ----
          double todoCount = 0;
          double todoCompleted = 0;
          double todoHalfCompleted = 0;
          double todoInadequated = 0;
          Map<String, double> todoMap;

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
              int _checked = 0;
              for (var todo in element.todoList!) {
                if (todo.checked == true) _checked++;
              }
              double _checkedPercent =
                  _checked * 100 / element.todoList!.length;
              if (_checkedPercent >= 100) {
                todoCompleted++;
              } else if (_checkedPercent >= 50) {
                todoHalfCompleted++;
              } else {
                todoInadequated++;
              }
            }
            if (isTmrDiaryWritten && isTyDiaryWritten) {
              diaryCompleted++;
            } else if (isTmrDiaryWritten) {
              tmrCount++;
            } else if (isTyDiaryWritten) {
              tyCount++;
            }
          }
          summaryMap = {
            "모두 완성": diaryCompleted,
            "내일의 일기만 완성": tmrCount,
            "오늘의 일기만 완성": tyCount,
            "둘 다 미완성": daysCount - diaryCompleted - tmrCount - tyCount,
          };

          todoMap = {
            "완벽": todoCompleted,
            "양호": todoHalfCompleted,
            "미흡": todoInadequated,
          };

          return Scaffold(
            backgroundColor: TdColor.black,
            appBar: AppBar(
              backgroundColor: TdColor.black,
              shadowColor: null,
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(CupertinoIcons.back)),
            ),
            body: SafeArea(
              child: ListView(
                padding: const EdgeInsets.all(TdSize.m),
                children: [
                  const TextWidget.header(text: '일기 완성도'),
                  const SizedBox(height: 15),
                  _buildPieChart(summaryMap),
                  const SizedBox(height: 30),
                  const TextWidget.header(text: 'Todo 달성도'),
                  const SizedBox(height: 15),
                  if (todoCount > 0)
                    _buildPieChart(todoMap)
                  else
                    const TextWidget.hint(text: "데이터가 없습니다."),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          // 에러가 있을 때
          return const Scaffold(
              backgroundColor: TdColor.brown,
              body: SafeArea(
                  child: Center(
                      child:
                          TextWidget.header(text: '데이터를 가져올 수 없습니다. 아...'))));
        } else {
          // 로딩 중일 때
          return Scaffold(
              backgroundColor: TdColor.brown,
              body: SafeArea(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Center(child: TextWidget.header(text: '분석 중...')),
                  SizedBox(height: 100),
                  CircularProgressIndicator(
                    color: TdColor.white,
                  ),
                ],
              )));
        }
      },
    );
  }

  Widget _buildPieChart(Map<String, double> dataMap) {
    return PieChart(
      dataMap: dataMap,
      animationDuration: Duration(milliseconds: 800),
      chartLegendSpacing: 32,
      chartRadius: MediaQuery.of(context).size.width / 3.2,
      // colorList: colorList,
      initialAngleInDegree: 0,
      chartType: ChartType.ring,
      ringStrokeWidth: 32,
      // centerText: "HYBRID",
      legendOptions: LegendOptions(
        showLegendsInRow: false,
        legendPosition: LegendPosition.bottom,
        showLegends: true,
        legendTextStyle: GoogleFonts.notoSans(
            fontSize: TdSize.s,
            fontWeight: FontWeight.bold,
            color: TdColor.white),
      ),
      chartValuesOptions: const ChartValuesOptions(
        showChartValueBackground: true,
        showChartValues: true,
        showChartValuesInPercentage: false,
        showChartValuesOutside: true,
        decimalPlaces: 0,
      ),
    );
  }
}
