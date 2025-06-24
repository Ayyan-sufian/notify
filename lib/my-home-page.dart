import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:notify_project/detail-audio.dart';

import 'my-tabs.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  List popularBooks = [];
  List books = [];
  late ScrollController _scrollController;
  late TabController _tabController;
  ReadData() async {
    await DefaultAssetBundle.of(
      context,
    ).loadString("json/popular-book.json").then((s) {
      setState(() {
        popularBooks = json.decode(s);
      });
    });

    await DefaultAssetBundle.of(context).loadString("json/books.json").then((
      s,
    ) {
      setState(() {
        books = json.decode(s);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    ReadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.black26, Colors.grey]),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 8, top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.widgets, size: 34, color: Colors.white),
                        Row(
                          children: [
                            Icon(Icons.search, size: 34, color: Colors.black),

                            MaterialButton(
                              onPressed: () {},
                              shape: CircleBorder(),
                              color: Colors.black,

                              child: Icon(
                                Icons.person,
                                size: 24,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 28.0),
                          child: Text(
                            'Popular Book',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Container(
                    height: 180,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: -20,
                          right: 0,
                          child: Container(
                            height: 180,
                            child: PageView.builder(
                              controller: PageController(viewportFraction: 0.8),
                              itemCount: popularBooks == null
                                  ? 0
                                  : popularBooks.length,
                              itemBuilder: (_, i) {
                                return Container(
                                  height: 180,
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsetsGeometry.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 7,
                                        color: Colors.grey.shade300,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                    image: DecorationImage(
                                      image: AssetImage(
                                        popularBooks[i]["images"],
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: NestedScrollView(
                      controller: _scrollController,
                      headerSliverBuilder:
                          (BuildContext context, bool isScroll) {
                            return [
                              SliverAppBar(
                                pinned: true,
                                backgroundColor: Colors.grey.shade900,
                                bottom: PreferredSize(
                                  preferredSize: Size.fromHeight(50),
                                  child: Container(
                                    margin: EdgeInsetsGeometry.only(
                                      bottom: 20,
                                      left: 10,
                                    ),
                                    child: TabBar(
                                      indicatorPadding:
                                          const EdgeInsetsGeometry.all(0),
                                      indicatorSize: TabBarIndicatorSize.label,
                                      labelPadding:
                                          const EdgeInsetsGeometry.only(
                                            right: 11,
                                          ),
                                      controller: _tabController,
                                      isScrollable: true,
                                      indicator: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      tabs: [
                                        MyTabs(
                                          color: Colors.black,
                                          text: "New",
                                        ),
                                        MyTabs(
                                          color: Colors.grey,
                                          text: "Trending",
                                        ),
                                        MyTabs(
                                          color: Colors.black,
                                          text: "Popular",
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ];
                          },
                      body: TabBarView(
                        controller: _tabController,
                        children: [
                          ListView.builder(
                            itemCount: books == null ? 0 : books.length,
                            itemBuilder: (_, i) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => detailAudio(
                                        booksData: books,
                                        index: i,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsetsGeometry.only(
                                    left: 20,
                                    top: 10,
                                    right: 20,
                                    bottom: 10,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white70,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 7,
                                          color: Colors.grey.shade300,
                                          offset: Offset(0, 0),
                                        ),
                                      ],
                                    ),
                                    child: Container(
                                      margin: const EdgeInsetsGeometry.all(8),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 90,
                                            height: 120,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              image: DecorationImage(
                                                image: AssetImage(
                                                  books[i]["images"],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 16),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(width: 5),
                                                  Icon(
                                                    Icons.star,
                                                    size: 20,
                                                    color: Colors.orangeAccent,
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    books[i]["rating"],
                                                    style: TextStyle(
                                                      color:
                                                          Colors.orangeAccent,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 5.0,
                                                ),
                                                child: Text(
                                                  books[i]["title"],
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 5.0,
                                                ),
                                                child: Text(
                                                  books[i]["text"],
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 5.0,
                                                ),
                                                child: Container(
                                                  width: 60,
                                                  height: 25,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          6,
                                                        ),
                                                    color: Colors.blueGrey,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      'Play',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          ListView.builder(
                            itemCount: books == null ? 0 : books.length,
                            itemBuilder: (_, i) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => detailAudio(
                                        booksData: books,
                                        index: i,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsetsGeometry.only(
                                    left: 20,
                                    top: 10,
                                    right: 20,
                                    bottom: 10,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white12,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 7,
                                          color: Colors.grey.shade300,
                                          offset: Offset(0, 0),
                                        ),
                                      ],
                                    ),
                                    child: Container(
                                      margin: const EdgeInsetsGeometry.all(8),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 90,
                                            height: 120,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              image: DecorationImage(
                                                image: AssetImage(
                                                  books[i]["images"],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 16),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(width: 5),
                                                  Icon(
                                                    Icons.star,
                                                    size: 20,
                                                    color: Colors.orangeAccent,
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    books[i]["rating"],
                                                    style: TextStyle(
                                                      color:
                                                          Colors.orangeAccent,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 5.0,
                                                ),
                                                child: Text(
                                                  books[i]["title"],
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 5.0,
                                                ),
                                                child: Text(
                                                  books[i]["text"],
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 5.0,
                                                ),
                                                child: Container(
                                                  width: 60,
                                                  height: 25,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          6,
                                                        ),
                                                    color: Colors.blueGrey,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      'Play',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          ListView.builder(
                            itemCount: books == null ? 0 : books.length,
                            itemBuilder: (_, i) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => detailAudio(
                                        booksData: books,
                                        index: i,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsetsGeometry.only(
                                    left: 20,
                                    top: 10,
                                    right: 20,
                                    bottom: 10,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white70,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 7,
                                          color: Colors.grey.shade300,
                                          offset: Offset(0, 0),
                                        ),
                                      ],
                                    ),
                                    child: Container(
                                      margin: const EdgeInsetsGeometry.all(8),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 90,
                                            height: 120,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              image: DecorationImage(
                                                image: AssetImage(
                                                  books[i]["images"],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 16),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(width: 5),
                                                  Icon(
                                                    Icons.star,
                                                    size: 20,
                                                    color: Colors.orangeAccent,
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    books[i]["rating"],
                                                    style: TextStyle(
                                                      color:
                                                          Colors.orangeAccent,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 5.0,
                                                ),
                                                child: Text(
                                                  books[i]["title"],
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 5.0,
                                                ),
                                                child: Text(
                                                  books[i]["text"],
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 5.0,
                                                ),
                                                child: Container(
                                                  width: 60,
                                                  height: 25,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          6,
                                                        ),
                                                    color: Colors.blueGrey,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      'Play',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
