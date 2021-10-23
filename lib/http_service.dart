import "package:http/http.dart";

class HttpService {
  Future<String> getRequest(String url, String token) async {
    final header = {"Authorization": "bearer $token"};
    Response response = await get(Uri.parse(url), headers: header);
    return response.body;
  }

  Future<String> postRequest(String url, String token, json) async {
    final headers = {"Content-type": "json", "Authorization": "bearer $token"};
    final response = await post(Uri.parse(url), headers: headers, body: json);
    return response.body;
  }
}
