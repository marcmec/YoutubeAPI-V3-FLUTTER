import 'package:flutter/material.dart';
import 'package:youtubeapiv3/src/videoplaylist.dart';

void main() => runApp(new YouApp());

class YouApp extends StatefulWidget {
  @override
  _StateYouApp createState() => new _StateYouApp();
}

class _StateYouApp extends State<YouApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Youtube Api V3",
      home: new HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          SizedBox(
              height: 90,
              child: Card(
                color: Colors.blue,
              )),
          Row(
            children: <Widget>[
              Padding(padding: EdgeInsets.all(10)),
              Icon(Icons.video_library),
              FlatButton(
                child: Text(
                  "Playlist",
                  textScaleFactor: 1.7,
                ),
                onPressed: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new VideoPlayList(
                            url:
                                "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=PLlBnICoI-g-d-v_fWlkZX2HRgHHPnJx9s&maxResults=10&key=" +
                                    "AIzaSyB07Y7jYTeg331vqjPSlbp8WVMZSWdFofA",
                            title: "YOUTUBE",
                          )));
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
