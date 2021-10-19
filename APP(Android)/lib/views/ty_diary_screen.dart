import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tomorrow_diary/controllers/controllers.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';

class TyDiaryScreen extends StatefulWidget {
  static const pageId = '/write/tydiary';

  final bool isEditable;

  const TyDiaryScreen({Key? key, required this.isEditable}) : super(key: key);

  @override
  State<TyDiaryScreen> createState() => _TyDiaryScreenState();
}

class _TyDiaryScreenState extends State<TyDiaryScreen> {
  DiaryController d = Get.find();
  CalendarController c = Get.find();
  UserController u =Get.find();
  GalleryController g = Get.find();
  @override
  void dispose() {
    if (widget.isEditable) {
      d.setPresentData();
      c.selectDay(c.selectedDay);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        behavior: HitTestBehavior.translucent,
        child: NestedScrollView(
          controller: ScrollController(),
          physics: const ScrollPhysics(parent: PageScrollPhysics()),
          headerSliverBuilder: (BuildContext context, bool isInnerBoxScrolled) {
            return <Widget>[
              SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(
                    height: 50,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: TdSize.m),
                        child:
                            TextWidget.body(text: '오늘의 일기 : ${c.selectedDate}'),
                      ),
                    ),
                  )
                ]),
              ),
            ];
          },
          body: ListView(
            padding: const EdgeInsets.symmetric(
                vertical: TdSize.m, horizontal: TdSize.xl),
            physics: const AlwaysScrollableScrollPhysics(),
            // 이 physics를 추가 안하면 listview로 화면이 가득 차지 않을 때 버그가 남.
            controller: PrimaryScrollController.of(context),
            children: [
              // ---제목---
              SingleLineForm(
                hint: "Title",
                //hint: '오늘의 일기 제목',
                text: d.allData.value.tyDiary!.title!,
                onChanged: _onTitleChanged,
              ),
              _largeGap,
              // ---오늘 있었던 일---
              const TextWidget.body(text: '오늘 있었던 일'),
              const SizedBox(height: 10),
              _smallGap,
              MultiLineForm(
                  hint: "what happened today?",
                  //hint: '오늘 있었던 일을 최대한 객관적으로 적어주세요',
                  text: d.allData.value.tyDiary!.tyHappen,
                  onChanged: _onTyHappenChanged),
              _largeGap,
              // ---위시 리스트---
              ((d.allData.value.tyDiary?.tyWish?.length ?? 0) > 0)
                  ? const TextWidget.body(text: '위시리스트')
                  : Container(),
              for (int i = 0;
                  i < (d.allData.value.tyDiary?.tyWish?.length ?? 0);
                  ++i)
                Obx(
                  () => Column(
                    children: [
                      _smallGap,
                      WishWidget(
                        text: d.allData.value.tyDiary?.tyWish?[i].wish ?? '',
                        wishListState:
                            d.allData.value.tyDiary?.tyWish?[i].checked ?? false
                                ? WishListState.checked
                                : WishListState.unchecked,
                        onTap: (checked) {
                          d.allData.value.tyDiary?.tyWish?[i].checked = checked;
                        },
                      ),
                    ],
                  ),
                ),
              ((d.allData.value.tyDiary?.tyWish?.length ?? 0) > 0)
                  ? _largeGap
                  : Container(),
              // ---오늘 깜짝! 놀랐던 일---
              const TextWidget.body(text: '오늘 깜짝! 놀랐던 일'),
              const SizedBox(height: 10),
              _smallGap,
              MultiLineForm(
                hint: 'Did you have any surprises?',
                text: d.allData.value.tyDiary!.tySurprise!,
                onChanged: _onTySurpriseChanged,
              ),
              _largeGap,
              // ---오늘의 진짜 기분---
              const TextWidget.body(text: '오늘의 진짜 기분'),
              const SizedBox(height: 10),
              _smallGap,
              SingleLineForm(
                hint: "How are u today?",
                //hint: '오늘의 진짜 기분은 어땠나요?',
                text: d.allData.value.tyDiary!.tyEmotion!,
                onChanged: _onTyEmotionChanged,
              ),
              _largeGap,
              // ---작성 완료 버튼---
              widget.isEditable
                  ? SubmitButtonWidget(
                      text: '작성 완료',
                      onSubmitted: _onTyDiarySubmitted,
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  final Widget _smallGap = const SizedBox(height: TdSize.s);
  final Widget _largeGap = const SizedBox(height: TdSize.l);
  void _onTitleChanged(String value) {
    d.allData.value.tyDiary?.title = value;
  }

  void _onTyHappenChanged(String value) {
    d.allData.value.tyDiary?.tyHappen = value;
  }

  void _onTySurpriseChanged(String value) {
    d.allData.value.tyDiary?.tySurprise = value;
  }

  void _onTyEmotionChanged(String value) {
    d.allData.value.tyDiary?.tyEmotion = value;
  }

  void _onTyDiarySubmitted() {
    d.setPresentData();

    u.checkPermit(u.principal.value.uid!);
    bool isAdmin = u.principal.value.isAdmin!;
    if(isAdmin || d.allData.value.tyDiary!.tyHappen!.isEmpty){
      bool isSameText = d.compareTyDiary(d.allData.value.tyDiary!.tyHappen);
     if(isSameText){
      d.getTextEmotion(d.allData.value.tyDiary!.tyHappen);
    }
   }else{
     g.emotion.value[0][TYPE]='';
   }

  }
}
