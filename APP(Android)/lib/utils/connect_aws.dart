import 'package:http/http.dart' as http; 

//기능 사용할려면 aws 추가해야함 

const awsImageEmotion = '';


const awsTextEmotion = '';

Future<http.Response> httpPostImg(String bytes) {
  return http.post(
    Uri.parse(awsImageEmotion),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: bytes,
  );
}
Future<http.Response> httpPostText(String bytes) {
  return http.post(
    Uri.parse(awsTextEmotion),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: bytes,
  );
}
