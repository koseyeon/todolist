import 'package:intl/intl.dart';

String formatDateTime(String dateTimeString) {
  // 입력된 문자열을 DateTime 객체로 변환
  DateTime dateTime = DateTime.parse(dateTimeString);

  // 형식 지정
  final formatter = DateFormat('yyyy년 M월 d일 a hh시 mm분 ss초');

  // 변환된 형식으로 포맷팅하여 반환
  return formatter.format(dateTime);
}
