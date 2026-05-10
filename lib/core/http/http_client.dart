import 'package:http/http.dart' as http;

abstract class HttpClient {
  Future get({required String url});
}

class HttpClientImpl implements HttpClient {
  @override
  Future get({required String url}) async {
    return await http.get(Uri.parse(url));
  }
}