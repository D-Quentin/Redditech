import "package:redditech/secret.dart";
import "package:redditech/http_service.dart";

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

  RequestNewPage(Secret secret) {
    return GetRequest("/subreddits/mine/subscriber", secret);
  }

  RequestUserData(Secret secret) {
    return GetRequest("api/v1/me", secret);
  }

  RequestSubscribedSubreddit(Secret secret) {
    return GetRequest("/subreddits/mine/subscriber", secret);
  }

  RequestNewPost(Secret secret, String subreddit) {
    print("/$subreddit/new");
    return GetRequest("/$subreddit/new", secret);
  }
}
