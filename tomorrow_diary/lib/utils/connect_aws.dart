  import 'package:http/http.dart' as http; //웹 땜시
  

  const aws = 'https://vnq0k7mhr0.execute-api.ap-northeast-2.amazonaws.com/tomorrow/image';
  Future<http.Response> httpPost(String bytes) {
  return http.post(
    Uri.parse(aws),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body:bytes,
    );
  }