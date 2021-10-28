import "package:redditech/secret.dart";
import "package:redditech/http_service.dart";
import 'package:http/http.dart' as http;

class APIRequest {
  final HttpService http_service = HttpService();
  final String url_base = "https://oauth.reddit.com";

  GetRequest(String url, Secret secret) {
    print(url_base + url);
    Future<dynamic> response =
        http_service.getRequest(url_base + url, secret.getToken());
    return response;
  }

  GetRequestWithHeader(String url, Secret secret, json) {
    Future<dynamic> response =
        http_service.getRequestHeader(url_base + url, secret.getToken(), json);
    return response;
  }

  PatchRequestWithHeader(String url, Secret secret, json) {
    Future<dynamic> response =
        http_service.patchRequest(url_base + url, secret.getToken(), json);
    return response;
  }

  SendRequestWithHeader(String url, Secret secret, json) {
    Future<dynamic> response =
        http_service.postRequest(url_base + url, secret.getToken(), json);
    return response;
  }

  RequestNewPage(Secret secret) {
    return GetRequest("/subreddits/mine/subscriber", secret);
  }

  RequestUserData(Secret secret) {
    return GetRequest("/api/v1/me", secret);
  }

  RequestSubscribedSubreddit(Secret secret) {
    return GetRequest("/subreddits/mine/subscriber", secret);
  }

  RequestNewPost(Secret secret, String subreddit) {
    print("/$subreddit/new");
    return GetRequest("/$subreddit/new", secret);
  }

  RequestUserSettings(Secret secret) {
    return GetRequest("/api/v1/me/prefs", secret);
  }

  UpdateUserSettings(Secret secret, String settings) {
    return PatchRequestWithHeader("/api/v1/me/prefs", secret, settings);
  }
}
