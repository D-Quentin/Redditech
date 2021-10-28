import "package:http/http.dart";

class HttpService {
  Future<String> getRequestHeader(
      String url, String token, Map<String, String> json) async {
    Map<String, String> header = {
      "Authorization": "bearer $token",
    };
    header.addAll(json);
    Response response = await get(Uri.parse(url), headers: header);
    return response.body;
  }

  Future<String> getRequest(String url, String token) async {
    final header = {"Authorization": "bearer $token"};
    Response response = await get(Uri.parse(url), headers: header);
    return response.body;
  }

  Future<String> postRequest(String url, String token, json) async {
    final headers = {"Authorization": "bearer $token"};
    final response = await post(Uri.parse(url), headers: headers, body: json);
    return response.body;
  }

  Future<String> patchRequest(String url, String token, json) async {
    final headers = {"Authorization": "bearer $token"};
    final response = await patch(Uri.parse(url), headers: headers, body: json);
    return response.body;
  }
}
