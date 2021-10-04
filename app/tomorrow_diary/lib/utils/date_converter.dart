class DateConverter {
  static String dateToString(int year, int month, int day) {
    return '${year.toString().padLeft(2, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
  }
}
