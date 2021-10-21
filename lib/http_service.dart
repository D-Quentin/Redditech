import "dart:convert";
import "package:http/http.dart";
import "package:redditech/post_model.dart";

class HttpService {
  final String postUrl = "https://reddit.com/";

  Future<List<Post>> getPosts() async {
    Response res = await get(Uri.parse(postUrl));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Post> posts = body.map((dynamic itm) => Post.fromJson(itm)).toList();

      return posts;
    } else
      throw "HttpService failed: unable to retrieve post";
  }
}
