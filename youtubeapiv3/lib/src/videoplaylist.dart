import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class VideoPlayList extends StatefulWidget {
  VideoPlayList({this.title, this.url});
  final String title;
  final String url;
  //apikey AIzaSyC8R3c_heItD8yntPYvWQS88zBEn8XUGyY
  //playlist id PLlBnICoI-g-d-v_fWlkZX2HRgHHPnJx9s
  @override
  _StatePLaylist createState() => new _StatePLaylist();
}

class _StatePLaylist extends State<VideoPlayList> {
  Map data;
  Future<List> getData() async {
    final response = await http.get(widget.url);

    data = json.decode(response.body);

    return data["items"];
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? new ListVideo(list: snapshot.data)
              : new CircularProgressIndicator();
        },
      ),
    );
  }
}

Future<void> executeVideo(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  }
}

class ListVideo extends StatelessWidget {
  final List list;
  ListVideo({this.list});
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      shrinkWrap: true,
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, index) {
        return new Container(
          padding: EdgeInsets.all(10),
          child: new Column(
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    executeVideo("https://www.youtube.com/watch?v=" +
                        list[index]["snippet"]["resourceId"]["videoId"]
                            .toString());
                  },
                  child: new Container(
                      height: 160,
                      width: 260,
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                            image: new NetworkImage(list[index]["snippet"]
                                ["thumbnails"]["high"]["url"]),
                            fit: BoxFit.cover),
                      ))),
              Text(list[index]["snippet"]["title"]),
            ],
          ),
        );
      },
    );
  }
}
