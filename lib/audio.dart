import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioTest extends StatefulWidget {
  @override
  _AudioTestState createState() => _AudioTestState();
}

class _AudioTestState extends State<AudioTest> {
  List musicList = [
    {
      'title': "Complicated",
      'singer': "Arulo",
      'url': "https://assets.mixkit.co/music/preview/mixkit-complicated-281.mp3"
    },
    {
      'title': "Night Sky",
      'singer': "Michael Ramir C",
      'url': "https://assets.mixkit.co/music/preview/mixkit-night-sky-970.mp3"
    },
    {
      'title': "Trip Hop Vibes",
      'singer': "Alejandro Magana",
      'url':
          "https://assets.mixkit.co/music/preview/mixkit-trip-hop-vibes-149.mp3"
    },
    {
      'title': "Feeling Happy",
      'singer': "Ahjay Stelino",
      'url':
          "https://assets.mixkit.co/music/preview/mixkit-feeling-happy-5.mp3",
    },
    {
      'title': "Silent Descent",
      'singer': "Eugenio Mininni",
      'url':
          "https://assets.mixkit.co/music/preview/mixkit-silent-descent-614.mp3",
    },
    {
      'title': "Cat Walk",
      'singer': "Arulo",
      'url': "https://assets.mixkit.co/music/preview/mixkit-cat-walk-371.mp3",
    }
  ];

  String currentTitle = '';
  String currentSinger = '';
  IconData btnIcon = Icons.play_arrow;

  Duration duration = Duration();
  Duration position = Duration();

  AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
  bool isPlaying = false;
  String currentSong = "";
  void playMusic(String url) async {
    if (isPlaying && currentSong != url) {
      audioPlayer.pause();
      int result = await audioPlayer.play(url);
      if (result == 1) {
        setState(() {
          currentSong = url;
          btnIcon = Icons.pause;
        });
      }
    } else if (!isPlaying) {
      int result = await audioPlayer.play(url);
      if (result == 1) {
        setState(() {
          isPlaying = true;
          btnIcon = Icons.play_arrow;
        });
      }
    }
    audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        duration = event;
      });
    });

    audioPlayer.onAudioPositionChanged.listen((event) {
      setState(() {
        position = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: ListView.builder(
              itemCount: musicList.length,
              itemBuilder: (context, int index) => ListTile(
                onTap: () {
                  playMusic(musicList[index]['url']);
                  setState(() {
                    currentTitle = musicList[index]['title'];
                    currentSinger = musicList[index]['singer'];
                  });
                },
                leading: CircleAvatar(
                  maxRadius: 30,
                  child: Text(musicList[index]['title'][0]),
                ),
                title: Text(musicList[index]['title']),
                subtitle: Text(musicList[index]['singer']),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Container(
                  child: Slider.adaptive(
                      value: position.inSeconds.toDouble(),
                      // min: 0,
                      max: duration.inSeconds.toDouble(),
                      onChanged: (value) {}),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: CircleAvatar(
                          maxRadius: 30,
                          child: Text(currentTitle),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                currentTitle,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              Text(
                                currentSinger,
                                style: Theme.of(context).textTheme.bodyText1,
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                            onPressed: () {
                              if (isPlaying) {
                                audioPlayer.pause();
                                setState(() {
                                  btnIcon = Icons.pause;
                                  isPlaying = false;
                                });
                              } else {
                                audioPlayer.resume();
                                setState(() {
                                  btnIcon = Icons.play_arrow;
                                  isPlaying = true;
                                });
                              }
                            },
                            icon: Icon(
                              btnIcon,
                              size: 42,
                            )),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
