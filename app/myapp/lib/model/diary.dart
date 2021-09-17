class Diary {
  String title; // 일기의 제목
  String author; // 작성자
  String? authorID; // ID
  String date; // 작성일
  String? editedDate; // 수정일
  Diary({required this.title, required this.author, required this.date});
}

class TomorrowDiary extends Diary {
  String happening; // 내일 있어야 할 일
  String wishlist; // 내일 있으면 좋거나 하고 싶은 일
  String face; // 내일 표정 예상
  TomorrowDiary(
      {required String title,
      required String author,
      required String date,
      required this.happening,
      required this.wishlist,
      required this.face})
      : super(title: title, author: author, date: date);
}

class TodayDiary extends Diary {
  String happening; // 오늘 있었던 일
  String wishlist; // 어제의 위시리스트
  String surprise; // 깜짝 놀랐던 일
  String face; // 오늘의 진짜 표정
  int goodDayPercent; // 알찬 정도
  TodayDiary(
      {required String title,
      required String author,
      required String date,
      required this.happening,
      required this.wishlist,
      required this.surprise,
      required this.face,
      required this.goodDayPercent})
      : super(title: title, author: author, date: date);
}
