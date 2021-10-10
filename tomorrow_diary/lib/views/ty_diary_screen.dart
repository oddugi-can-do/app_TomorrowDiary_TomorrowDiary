import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tomorrow_diary/controllers/controllers.dart';
import 'package:tomorrow_diary/controllers/diary_controller.dart';
import 'package:tomorrow_diary/utils/utils.dart';
import 'package:tomorrow_diary/widgets/widgets.dart';




class TyDiaryScreen extends StatefulWidget {
  static const pageId = '/write/tydiary';

  @override
  State<TyDiaryScreen> createState() => _TyDiaryScreenState();
}

class _TyDiaryScreenState extends State<TyDiaryScreen> {
  DiaryController d = Get.find();
  CalendarController c = Get.find();

  @override
  void dispose() {
    c.selectDay(c.selectedDay);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   final _verticalOffset = MediaQuery.of(context).viewInsets.bottom * -1.0;

    return Ink(
      color: Colors.black87,
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
        body:  ListView(
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
            SizedBox(height: 10),
            _smallGap,
            MultiLineForm(
                hint: "what happened today?",
                //hint: '오늘 있었던 일을 최대한 객관적으로 적어주세요',
                text: d.allData.value.tyDiary!.tyHappen,
                onChanged: _onTyHappenChanged),
            _largeGap,
            // ---위시 리스트---
            const TextWidget.body(text: '위시리스트'),
            /* 위시리스트 시작 */
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
            /* 위시리스트 종료 */
            _largeGap,
            // ---오늘 깜짝! 놀랐던 일---
            const TextWidget.body(text: '오늘 깜짝! 놀랐던 일'),
            SizedBox(height: 10),
            _smallGap,
            MultiLineForm(
              hint: 'Did you have any surprises?',
              text: d.allData.value.tyDiary!.tySurprise!,
              onChanged: _onTySurpriseChanged,
            ),
            _largeGap,
            // ---오늘의 진짜 기분---
            const TextWidget.body(text: '오늘의 진짜 기분'),
            SizedBox(height: 10),
            _smallGap,
            SingleLineForm(
              hint: "How are u today?",
              //hint: '오늘의 진짜 기분은 어땠나요?',
              text: d.allData.value.tyDiary!.tyEmotion!,
              onChanged: _onTyEmotionChanged,
            ),
            _largeGap,
            // ---작성 완료 버튼---
            SubmitButtonWidget(
              text: '작성 완료',
              onSubmitted: _onTyDiarySubmitted,
            ),
          ],
        ),
      ),
    );
  }

  final Widget _smallGap = const SizedBox(height: TdSize.s);
  final Widget _largeGap = const SizedBox(height: TdSize.l);
  void _onTitleChanged(String value) {
    d.allData.value.tyDiary?.title = value;
    print('tyDiary title changed : ${d.allData.value.tyDiary?.title}');
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
  }
}



/*
 * 리펙토링 이유 : 
 * 1. 코드가 깨끗하지 않음. Screen 설계 의도와 다르게 흘러감.
 * 2. Stateless -> Stateful
 *  
 * 어떻게 리펙토링 할 것인가?
 * 1. build() 안에 NestedScrollView를 만들어서 자동화 할 생각하지 말고 다 쑤셔넣기
 * 2. Wish list를 표현할 때는 column에 따로 넣기. 추가할 때 UI 변경이 용이하게.
 * 3. https://github.com/flutter/codelabs/blob/master/firebase-get-to-know-flutter/step_09/lib/main.dart
 * 여기 아래부분 참고하기.
 * 4. 코드 깔끔하게. 왠만하면 Widget들만 있도록 하기. 나머지는 Utils에 빼기
 * (5. 데이터 묶어서 보내는 것을 더 용이하게 바꾸기. 너무 난잡함.)
 * 
 * TODO:
 * 완료. 1. ty_diary_screen.dart
 * 2. tmr_diary_screen.dart
 * 3. todo_list_screen.dart
 * 다 바꾸기. 특히 todo_list_screen.dart는 손 볼게 많음.
 * 4. Calendar 부분 짤리는거 minimum size만 둬보기.
*/
/*
  Future<dynamic> buildTyDiaryModal(BuildContext context) {
    List<Widget> _listItems = [];
    if (tyDiary != null) {
      _listItems = _addListItemsFromTyDiary(tyDiary!);
    } else {
      _listItems = _addDefaultTyListItems();
    }
    return ModalUtil.barModalWithListItems(context, _listItems, '오늘의 일기');
  }

  final Widget _smallGap = const SizedBox(height: TdSize.s);
  final Widget _largeGap = const SizedBox(height: TdSize.l);

  DiaryController d = Get.find();
  CalendarController c = Get.find();

  void _onTitleChanged(String value) {
    d.allData.value.tyDiary?.title = value;
    print('tyDiary title changed : ${d.allData.value.tyDiary?.title}');
  }

  void _onTyHappenChanged(String value) {
    d.allData.value.tyDiary?.tyHappen = value;
  }

  // void _onTyWishChanged(List<Wish> value) {
  //   d.allData.value.tyDiary?.tyWish = value;
  // }

  void _onTySurpriseChanged(String value) {
    d.allData.value.tyDiary?.tySurprise = value;
  }

  void _onTyEmotionChanged(String value) {
    d.allData.value.tyDiary?.tyEmotion = value;
  }

  void _onTyDiarySubmitted() {
    d.setPresentDataByDate(c.selectedDate);
  }

  List<Widget> _addListItemsFromTyDiary(TyDiary tyDiary) {
    List<Widget> _listItems = [];
    // ---제목---
    _listItems.add(tyDiary.title == null
        ? SingleLineForm(
            hint: '오늘의 일기 제목',
            onChanged: _onTitleChanged,
          )
        : SingleLineForm(
            text: tyDiary.title!,
            onChanged: _onTitleChanged,
          ));
    _listItems.add(_largeGap);
    // ---오늘 있었던 일---
    _listItems.add(const TextWidget.body(text: '오늘 있었던 일'));
    _listItems.add(_smallGap);
    _listItems.add(
      tyDiary.tyHappen == null
          ? MultiLineForm(
              hint: '오늘 있었던 일을 최대한 객관적으로 적어주세요',
              onChanged: _onTyHappenChanged,
            )
          : MultiLineForm(
              text: tyDiary.tyHappen!, onChanged: _onTyHappenChanged),
    );
    _listItems.add(_largeGap);
    // ---위시 리스트---
    _listItems.add(const TextWidget.body(text: '위시리스트'));
    _listItems.addAll(ModalUtil.tyWishWidgetFromStringList(tyDiary.tyWish));
    _listItems.add(_largeGap);
    // ---오늘 깜짝! 놀랐던 일---
    _listItems.add(const TextWidget.body(text: '오늘 깜짝! 놀랐던 일'));
    _listItems.add(const SizedBox(height: TdSize.s));
    _listItems.add(
      tyDiary.tyHappen == null
          ? MultiLineForm(
              hint: '예상치 못한 일이 있었나요?',
              onChanged: _onTySurpriseChanged,
            )
          : MultiLineForm(
              text: tyDiary.tySurprise!,
              onChanged: _onTySurpriseChanged,
            ),
    );
    _listItems.add(_largeGap);
    // ---오늘의 진짜 기분---
    _listItems.add(const TextWidget.body(text: '오늘의 진짜 기분'));
    _listItems.add(_smallGap);
    _listItems.add(
      tyDiary.title == null
          ? SingleLineForm(
              hint: '오늘의 진짜 기분은 어땠나요?',
              onChanged: _onTyEmotionChanged,
            )
          : SingleLineForm(
              text: tyDiary.tyEmotion!,
              onChanged: _onTyEmotionChanged,
            ),
    );
    _listItems.add(_largeGap);
    // ---작성 완료 버튼---
    _listItems.add(
      SubmitButtonWidget(
        text: '작성 완료',
        onSubmitted: _onTyDiarySubmitted,
      ),
    );
    return _listItems;
  }

  List<Widget> _addDefaultTyListItems() {
    List<Widget> _listItems = [];
    // ---제목---
    _listItems.add(SingleLineForm(
      hint: '오늘의 일기 제목',
      onChanged: _onTitleChanged,
    ));
    _listItems.add(_largeGap);
    // ---오늘 있었던 일---
    _listItems.add(const TextWidget.body(text: '오늘 있었던 일'));
    _listItems.add(_smallGap);
    _listItems.add(MultiLineForm(
      hint: '오늘 있었던 일을 최대한 객관적으로 적어주세요',
      onChanged: _onTyHappenChanged,
    ));
    _listItems.add(_largeGap);
    // ---위시 리스트---
    _listItems.add(const TextWidget.body(text: '위시리스트'));
    _listItems.add(_smallGap);
    _listItems.add(const TextWidget.hint(text: '설정된 위시리스트가 없습니다.'));
    _listItems.add(_largeGap);
    // ---오늘 깜짝! 놀랐던 일---
    _listItems.add(const TextWidget.body(text: '오늘 깜짝! 놀랐던 일'));
    _listItems.add(const SizedBox(height: TdSize.s));
    _listItems.add(
      MultiLineForm(
        hint: '예상치 못한 일이 있었나요?',
        onChanged: _onTySurpriseChanged,
      ),
    );
    _listItems.add(_largeGap);
    // ---오늘의 진짜 기분---
    _listItems.add(const TextWidget.body(text: '오늘의 진짜 기분'));
    _listItems.add(_smallGap);
    _listItems.add(SingleLineForm(
      hint: '내일의 기분을 미리 예측해 보세요.',
      onChanged: _onTyEmotionChanged,
    ));
    _listItems.add(_largeGap);
    // ---작성 완료 버튼---
    _listItems.add(
        SubmitButtonWidget(text: '작성 완료', onSubmitted: _onTyDiarySubmitted));
    return _listItems;
  }
  */
