import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VideoPlayList extends StatefulWidget {
  VideoPlayList({this.title, this.url});
  final String title;
  final String url;
  //apikey AIzaSyC8R3c_heItD8yntPYvWQS88zBEn8XUGyY
  //playlist id PLFlfI-YjrJuRazkbnVC1tkRDVKeOBjgAu
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
              new Container(
                height: 160,
                width: 260,
                  decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new NetworkImage(
                    list[index]["snippet"]["thumbnails"]["high"]["url"]
                  ),
                  fit: BoxFit.cover
                ),
              )),

              Text(list[index]["snippet"]["title"]),
            ],
          ),
        );
      },
    );
  }
}
