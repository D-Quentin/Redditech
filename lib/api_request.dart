import "dart:convert";
import "package:redditech/secret.dart";
import "package:redditech/http_service.dart";

class APIRequest {
  final HttpService httpService = HttpService();
  final String urlBase = "https://oauth.reddit.com";

  getRequest(String url, Secret secret) {
    Future<dynamic> response =
        httpService.getRequest(urlBase + url, secret.getToken());
    return response;
  }

  getRequestWithHeader(String url, Secret secret, Map<String, String> json) {
    Future<dynamic> response =
        httpService.getRequestHeader(urlBase + url, secret.getToken(), json);
    return response;
  }

  postRequest(
      String url, Map<String, String> header, Map<String, String> body) {
    Future<dynamic> response = httpService.postRequest(url, header, body);
    return response;
  }

  requestNewPage(Secret secret) {
    return getRequest("/subreddits/mine/subscriber", secret);
  }

  requestUserData(Secret secret) {
    return getRequest("api/v1/me", secret);
  }

  requestSubscribedSubreddit(Secret secret) {
    return getRequest("/subreddits/mine/subscriber", secret);
  }

  requestNewPost(Secret secret) {
    return getRequestWithHeader("/new", secret, {"limit": "10"});
  }

  requestNewPostAfter(Secret secret, Map<String, String> header) {
    return getRequestWithHeader("/new", secret, header);
  }

  requestToken(Secret secret) {
    final String id = secret.getClientID();
    final String secret_ = secret.getSecret();

    return postRequest("https://ssl.reddit.com/api/v1/access_token", {
      "Authorization": "Basic " + base64.encode(utf8.encode("$id:$secret_"))
    }, {
      "grant_type": "authorization_code",
      "code": secret.getCode(),
      "redirect_uri": secret.getRedirectUri()
    });
  }
}
