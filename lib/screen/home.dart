import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:movie_flutter/custom/itemRatingMovie.dart';
import 'package:movie_flutter/custom/itemTab.dart';
import 'package:movie_flutter/custom/posterMovie.dart';

import 'package:movie_flutter/models/movie.dart';
import 'package:movie_flutter/models/user.dart';
import 'package:movie_flutter/screen/movieDetail.dart';
import 'package:movie_flutter/services/servicesMovie.dart';

class Home extends StatefulWidget {
  final User user;

  const Home({Key key, this.user}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.8);
  int _selectPage = 0;
  List<Movie> list = [];
  bool cekData = false;

  // Inisialisasi Fire base
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
  void initState() {
    _firebaseMessaging.getToken().then((value) {
      print("FCM TOKEN $value");
    });

    ServicesMovie.getNowPlaying().then((value) {
      setState(() {
        list = value;
        if (list.length > 0) {
          cekData = true;
        } else {
          cekData = false;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue[300],
                Colors.indigo[800],
              ],
            ),
          ),
          child: TabBarView(
            children: [
              cekData
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 90,
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 50),
                            child: PageView.builder(
                              onPageChanged: (a) {
                                setState(() {
                                  _selectPage = a;
                                });
                              },
                              controller: pageController,
                              itemCount: list.length,
                              itemBuilder: (context, i) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MovieDetail(
                                                  index: i,
                                                  models: list[i],
                                                )));
                                  },
                                  child: PosterMovie(
                                    selectPage: _selectPage,
                                    index: i,
                                    imgUrl:
                                        "https://image.tmdb.org/t/p/w220_and_h330_face${list[i].posterPath}",
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Text(
                          "${list[_selectPage].originalTitle}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Category Movie | 2 Hours",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ItemRating(
                              rating: "${list[_selectPage].voteAverage}",
                              titleRating: "Vote Avarage",
                            ),
                            ItemRating(
                              rating: "${list[_selectPage].popularity}",
                              titleRating: "Popularity",
                            ),
                            ItemRating(
                              rating: "${list[_selectPage].voteCount}",
                              titleRating: "Vote Count",
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 60),
                          padding: EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                width: 3,
                                color: Colors.white,
                              )),
                          child: Text(
                            "Buy Tickets",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                      ],
                    )
                  : Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
              Container(
                child: Center(
                  child: Text("Popular"),
                ),
              ),
              Container(
                child: Center(
                  child: Text("Top Rated"),
                ),
              ),
              Container(
                child: Center(
                  child: Text("Coming Soon"),
                ),
              ),
            ],
          ),
        ),
        drawer: Drawer(),
        // NAVIGASI ATAS
        appBar: AppBar(
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey[400],
            indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
              color: Colors.white,
              width: 0.5,
            )),
            isScrollable: true,
            tabs: [
              ItemTabs(
                icon: Icons.home,
                title: "Now Playing",
              ),
              ItemTabs(
                icon: Icons.favorite,
                title: "Popular",
              ),
              ItemTabs(
                icon: Icons.feedback,
                title: "Top Rated",
              ),
              ItemTabs(
                title: "Coming Soon",
                icon: Icons.history,
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text("Movies"),
          centerTitle: true,
          // MENU SEBELAH KANAN ATAS
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(3600),
                child: Image.network(
                  "${widget.user.photo}",
                  fit: BoxFit.cover,
                  width: 40,
                  height: 40,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
