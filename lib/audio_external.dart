import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';

class AudioExternal extends StatefulWidget {
  @override
  _AudioExternalState createState() => _AudioExternalState();
}

class _AudioExternalState extends State<AudioExternal> {
  @override
  void initState() async {
    super.initState();
    musicPlayer();
  }

  List<Song> _song;
  void musicPlayer() async {
    var songs = await MusicFinder.allSongs();
    _song = new List.from(songs);

    setState(() {
      _song = songs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _song.length,
              itemBuilder: (context, int index) => ListTile(
                leading: CircleAvatar(
                  child: Text(_song[index].title[0]),
                ),
                title: Text(_song[index].title),
              ),
            ),
          ),
          // Expanded(child: child),
        ],
      ),
    );
  }
}
