import "package:flutter/material.dart";
import 'package:redditech/postWidget/reddit_post_widget.dart';
import "package:redditech/secret.dart";
import "package:redditech/post_model.dart";
import "package:flutter/cupertino.dart";
import "package:redditech/api_request.dart";
import "package:pull_to_refresh/pull_to_refresh.dart";

enum FeedPage {
  new_,
  top_,
  hot_,
}

class FeedPageWidget extends StatefulWidget {
  FeedPageWidget(this.secret, this.feedpage);

  final Secret secret;
  final FeedPage feedpage;

  @override
  FeedPageStateWidget createState() => FeedPageStateWidget(secret);
}

class FeedPageStateWidget extends State<FeedPageWidget> {
  FeedPageStateWidget(this.secret);

  final Secret secret;
  bool firstLoad = true;
  String jsonContent = "";
  List<Post> postList = [];
  APIRequest api = APIRequest();
  String selectedSubreddit = "All";
  Unserializer unserializer = Unserializer();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void changeSelectedSubreddit(String sub) {
    this.setState(() {
      this.selectedSubreddit = sub;
    });
  }

  List<String> getDropdownItem(List<SubscribedSubreddit>? snap) {
    List<String> dropitem = [];

    dropitem.add("All");
    if (snap == null) {
      return dropitem;
    }
    for (var it = snap.iterator; it.moveNext();) {
      dropitem.add(it.current.display_name);
    }
    return dropitem;
  }

  Future<List<SubscribedSubreddit>> getSubscribbedSubredditList() async {
    api.requestSubscribedSubreddit(this.secret).then((String string) {
      return unserializer.getSubcribbedSubredditFromJson(string);
    });
    return [];
  }

  void _firstLoad() async {
    await api.requestPost(this.secret, widget.feedpage).then((String string) {
      postList = unserializer.getPostFromJson(string);
      if (mounted) setState(() {});
      _refreshController.refreshCompleted();
    });
  }

  void _onRefresh() async {
    await api.requestPost(this.secret, widget.feedpage).then((String string) {
      postList = unserializer.getPostFromJson(string);
      if (mounted) setState(() {});
      _refreshController.refreshCompleted();
    });
  }

  void _onLoading() async {
    await api
        .requestPostAfter(this.secret, widget.feedpage,
            "?after=${postList.last.after}&count=${postList.length}")
        .then((String string) {
      List<Post> postListAfter = unserializer.getPostFromJson(string);
      postList.addAll(postListAfter);
      if (mounted) setState(() {});
      _refreshController.loadComplete();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (firstLoad) {
      this._firstLoad();
      this.firstLoad = false;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        toolbarHeight: 30,
        leading: Padding(
          padding: EdgeInsets.only(left: 10),
          child: FutureBuilder<List<SubscribedSubreddit>>(
            future: getSubscribbedSubredditList(),
            builder: (BuildContext context,
                AsyncSnapshot<List<SubscribedSubreddit>> snap) {
              if (snap.hasData && snap.data != null) {
                return DropdownButtonHideUnderline(
                  child: DropdownButton(
                    items: getDropdownItem(snap.data)
                        .map<DropdownMenuItem<String>>(
                      (String str) {
                        return DropdownMenuItem<String>(
                          child: Text(
                            str,
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                );
              }
              return DropdownButtonHideUnderline(
                child: DropdownButton(
                  items: [
                    DropdownMenuItem(
                        child: Text(
                      "Add",
                      style: TextStyle(color: Colors.black),
                    )),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus? mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("pull up load");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("Load Failed! Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("Release to load more");
            } else {
              body = Text("No more Data");
            }
            return Container(
              height: 100.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.builder(
          itemBuilder: (c, i) => Card(
            color: Color.fromARGB(255, 240, 240, 240),
            child: RedditechPostWidget(postList[i], secret),
          ),
          itemCount: postList.length,
        ),
      ),
    );
  }
}
