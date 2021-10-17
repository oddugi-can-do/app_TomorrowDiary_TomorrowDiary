import 'package:http/http.dart' as http; 

//기능 사용할려면 aws 추가해야함 
const aws = '';
Future<http.Response> httpPost(String bytes) {
  return http.post(
    Uri.parse(aws),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: bytes,
  );
}
