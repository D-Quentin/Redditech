import "package:http/http.dart";

class HttpService {
  Future<String> getRequestHeader(
      String url, String token, Map<String, String> json) async {
    Map<String, String> header = {
      "Content-Type": "application/json",
      "Authorization": "bearer $token"
    };
    header.addAll(json);
    Response response = await get(Uri.parse(url), headers: header);
    return response.body;
  }

  Future<String> getRequest(String url, String token) async {
    print(token);
    final header = {
      "Content-Type": "application/json",
      "Authorization": "bearer $token"
    };
    Response response = await get(Uri.parse(url), headers: header);
    return response.body;
  }

  Future<String> postRequest(
      String url, Map<String, String> header, Map<String, String> body) async {
    final Response response =
        await post(Uri.parse(url), headers: header, body: body);
    return response.body;
  }

  Future<String> patchRequest(String url, String token, json) async {
    final headers = {"Authorization": "bearer $token"};
    final response = await patch(Uri.parse(url), headers: headers, body: json);
    return response.body;
  }
}
