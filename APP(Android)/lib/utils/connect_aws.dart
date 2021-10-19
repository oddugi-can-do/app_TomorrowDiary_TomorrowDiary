import 'package:http/http.dart' as http; 

//기능 사용할려면 aws 추가해야함 

const awsImageEmotion = 'https://vnq0k7mhr0.execute-api.ap-northeast-2.amazonaws.com/tomorrow/cWphd25zcmhrd2hkZGxzZGxhbHds';


const awsTextEmotion = 'https://vnq0k7mhr0.execute-api.ap-northeast-2.amazonaws.com/tomorrow/cWphd25zcmhrd2hkZGxzeHBydG14bQ';

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