import "package:redditech/secret.dart";
import "package:redditech/http_service.dart";

class APIRequest {
  final String url_base = "https://oauth.reddit.com";
  final HttpService http_service = HttpService();

  RequestNewPage(Secret secret) {
    Future<dynamic> sub_subreddits = http_service.getRequest(
        url_base + "/subreddits/mine/subscriber", secret.getToken());
    return (sub_subreddits);
  }

  RequestUserData(Secret secret) {
    Future<dynamic> username =
        http_service.getRequest(url_base + "/api/v1/me", secret.getToken());
    return (username);
  }
}
