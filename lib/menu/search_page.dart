import "dart:convert";
import 'package:redditech/menu/feed_page.dart';
import "package:redditech/secret.dart";
import "package:flutter/material.dart";
import "package:redditech/post_model.dart";
import "package:redditech/api_request.dart";
import "package:flutter_typeahead/flutter_typeahead.dart";

class SearchPageListWidget extends StatefulWidget {
  SearchPageListWidget(this.secret);

  final Secret secret;
  final APIRequest api = APIRequest();
  final Unserializer unserializer = Unserializer();

  SearchPageListState createState() => SearchPageListState();
}

class SearchPageListState extends State<SearchPageListWidget> {
  Future<List<String>> getSuggestion(String querry) async {
    Future<String> list =
        widget.api.requestSearchSubreddit(widget.secret, querry);
    List<SubscribedSubreddit> sub =
        widget.unserializer.getSubcribbedSubredditFromJson(await list);
    List<String> suggestion = [];
    for (var it = sub.iterator; it.moveNext();) {
      suggestion.add(it.current.display_name);
    }
    return suggestion;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 30, top: 30, right: 30),
        child: TypeAheadField(
          textFieldConfiguration: TextFieldConfiguration(
            autofocus: true,
            style: DefaultTextStyle.of(context)
                .style
                .copyWith(fontStyle: FontStyle.normal),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          suggestionsCallback: (pattern) {
            return (getSuggestion(pattern));
          },
          itemBuilder: (context, suggestion) {
            if (suggestion != null) {
              return ListTile(
                title: Text(suggestion.toString()),
              );
            }
            return CircularProgressIndicator();
          },
          onSuggestionSelected: (suggestion) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    SubredditHeaderWidget(widget.secret, suggestion)));
          },
        ),
      ),
    );
  }
}

class SubredditHeaderWidget extends StatefulWidget {
  SubredditHeaderWidget(this.secret, this.subreddit);

  final subreddit;
  final Secret secret;

  SubredditHeaderWidgetState createState() =>
      SubredditHeaderWidgetState(secret, subreddit);
}

class SubredditHeaderWidgetState extends State<SubredditHeaderWidget> {
  SubredditHeaderWidgetState(this.secret, this.subreddit);

  final Secret secret;
  final subreddit;
  bool firstLoad = false;
  final APIRequest api = APIRequest();
  final Unserializer unserializer = Unserializer();
  SubredditInfo sub_info = SubredditInfo(" ", " ", " ", " ", " ");

  Future<SubredditInfo> getSubredditHeader() async {
    await api
        .requestSubredditAbout(this.secret, this.subreddit)
        .then((String str) {
      print("test1");
      var test = unserializer.getSubredditInfo(str);
      print("test2");
    });
    return SubredditInfo("", "", "", "", "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<SubredditInfo>(
        future: getSubredditHeader(),
        builder: (BuildContext context, AsyncSnapshot<SubredditInfo> snap) {
          if (snap.hasData) {
            return Row(
              children: [
                Text("Test"),
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
