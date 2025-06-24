import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'audio-file.dart';
import 'my-home-page.dart';

class detailAudio extends StatefulWidget {
  final booksData;
  final int index;
  const detailAudio({super.key, required this.booksData, required this.index});

  @override
  State<detailAudio> createState() => detailAudioState();
}

class detailAudioState extends State<detailAudio> {
  bool isToggeled = false;
  bool isCliked = false;
  List popularBook = [];
  List<IconData> _icon = [
    Icons.favorite_border,
    Icons.favorite,
    Icons.star,
    CupertinoIcons.star,
    Icons.share,
  ];

  Widget btnFav() {
    return IconButton(
      onPressed: () {
        setState(() {
          isToggeled = !isToggeled; // Toggle between true and false
        });
      },
      icon: Icon(
        isToggeled ? _icon[1] : _icon[0], // Show different icon
        size: 38,
        color: isToggeled ? Colors.red : Colors.grey,
      ),
    );
  }

  Widget btnRat() {
    return IconButton(
      onPressed: () {
        setState(() {
          isCliked = !isCliked; // Toggle between true and false
        });
      },
      icon: Icon(
        isCliked ? _icon[3] : _icon[2], // Show different icon
        size: 38,
        color: isCliked ? Colors.grey : Colors.red,
      ),
    );
  }

  AudioPlayer advancePlayer = AudioPlayer();
  @override
  void initState() {
    super.initState();
    advancePlayer = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.white12, Colors.black]),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: MediaQuery.of(context).size.height / 4,
              child: Container(color: Colors.black),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: MediaQuery.of(context).size.height / 4,
              child: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
                  onPressed: () {
                    advancePlayer.stop();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyHomePage(title: ''),
                      ),
                    );
                  },
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.search, size: 28, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Positioned(
              top: screenHeight * 0.2,
              left: 0,
              right: 0,
              child: Container(
                height: screenHeight * 0.36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(41),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    SizedBox(height: screenHeight * 0.1),
                    Text(
                      this.widget.booksData[this.widget.index]["title"],
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      this.widget.booksData[this.widget.index]["text"],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    AudioFile(
                      advancePlayer: advancePlayer,
                      audioPath:
                          this.widget.booksData[this.widget.index]["audio"],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.12,
              left: (screenWidth - 150) / 2,
              right: (screenWidth - 150) / 2,
              height: screenHeight * 0.14,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(21),
                  border: Border.all(color: Colors.white70, width: 2),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(21),
                    border: Border.all(color: Colors.white70, width: 2),
                    image: DecorationImage(
                      image: AssetImage(
                        this.widget.booksData[this.widget.index]["images"],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: screenHeight * 20,
              left: 10,
              right: 10,
              child: Container(
                height: 180,
                color: Colors.white,
                child: Text(
                  "Add playlist",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: screenHeight * 0.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(41),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    btnFav(),
                    btnRat(),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(_icon[4], size: 38, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
