import 'package:flutter/cupertino.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioFile extends StatefulWidget {
  final AudioPlayer advancePlayer;
  final String audioPath;
  const AudioFile({
    super.key,
    required this.advancePlayer,
    required this.audioPath,
  });

  @override
  State<AudioFile> createState() => AudioFileState();
}

class AudioFileState extends State<AudioFile> {
  Duration _duration = new Duration();
  Duration _position = new Duration();
  bool isPlaying = false;
  bool isPaused = false;
  bool isRepeat = false;
  List<IconData> _icon = [
    Icons.play_circle_fill,
    Icons.pause_circle_filled,
    Icons.fast_forward_rounded,
    Icons.fast_rewind,
    Icons.loop_outlined,
    Icons.repeat,
  ];

  @override
  void initState() {
    super.initState();
    this.widget.advancePlayer.onDurationChanged.listen((d) {
      setState(() {
        _duration = d;
      });
    });
    this.widget.advancePlayer.onPositionChanged.listen((p) {
      setState(() {
        _position = p;
      });
    });
    this.widget.advancePlayer.onPlayerComplete.listen((event) {
      setState(() {
        _position = Duration(seconds: 0);
        if (isRepeat == true) {
          isPlaying = true;
        } else {
          isPlaying = false;
          isRepeat = false;
        }
      });
    });
  }

  Widget btnStart() {
    return IconButton(
      padding: EdgeInsets.only(bottom: 10),
      icon: isPlaying == false
          ? Icon(_icon[0], size: 50, color: Colors.black)
          : Icon(_icon[1], size: 50, color: Colors.black),
      onPressed: () {
        if (isPlaying == false) {
          this.widget.advancePlayer.play(UrlSource(this.widget.audioPath));
          setState(() {
            isPlaying = true;
          });
        } else if (isPlaying == true) {
          this.widget.advancePlayer.pause();
          setState(() {
            isPlaying = false;
          });
        }
      },
    );
  }

  Widget btnFast() {
    return IconButton(
      icon: Icon(_icon[2], size: 25),
      onPressed: () {
        this.widget.advancePlayer.setPlaybackRate(1.5);
      },
    );
  }

  Widget btnSlow() {
    return IconButton(
      icon: Icon(_icon[3], size: 25),
      onPressed: () {
        this.widget.advancePlayer.setPlaybackRate(0.5);
      },
    );
  }

  Widget btnLoop() {
    return IconButton(
      icon: Icon(_icon[4], size: 25, color: Colors.black),
      onPressed: () {
        if (isRepeat == false) {
          this.widget.advancePlayer.setReleaseMode(ReleaseMode.loop);
          setState(() {
            isRepeat = true;
          });
        } else if (isRepeat == true) {
          this.widget.advancePlayer.setReleaseMode(ReleaseMode.release);
          isRepeat = false;
        }
      },
    );
  }

  Widget btnRepeat() {
    return IconButton(
      icon: Icon(_icon[5], size: 25, color: Colors.black),
      onPressed: () {},
    );
  }

  Widget loadAssest() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [btnRepeat(), btnSlow(), btnStart(), btnFast(), btnLoop()],
      ),
    );
  }

  Widget slider() {
    return Slider(
      activeColor: Colors.red,
      inactiveColor: Colors.grey,
      value: _position.inSeconds.toDouble(),
      min: 0.0,
      max: _duration.inSeconds.toDouble(),
      onChanged: (double value) {
        setState(() {
          changeToSecond(value.toInt());
          value = value;
        });
      },
    );
  }

  void changeToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    this.widget.advancePlayer.seek(newDuration);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _position.toString().split(".")[0],
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  _duration.toString().split(".")[0],
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          slider(),
          loadAssest(),
        ],
      ),
    );
  }
}
