import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/Screens/category_screen.dart';
import 'package:news_app/Screens/news_description.dart';
import 'package:news_app/models/news_channel_headlines.dart';
import 'package:news_app/view_model/news_from_source_category.dart';
import 'package:news_app/view_model/news_view_model.dart';

enum FilterList { bbcnews, abcnews, bloomberg, cnn }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final newsViewModel = NewsViewModel();
final format = DateFormat('MMMM dd, yyyy');
String name = 'bbc-news';

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => const NewsCategoryScreen()));
              },
              icon: Container(
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  'assets/images/category_icon.png',
                ),
              )),
          title: Text(
            'News',
            style:
                GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          actions: [
            PopupMenuButton(
              initialValue: FilterList.bbcnews,
              itemBuilder: (ctx) => [
                const PopupMenuItem(
                    value: FilterList.bbcnews, child: Text('BBC News')),
                const PopupMenuItem(
                    value: FilterList.abcnews, child: Text('ABC News')),
                const PopupMenuItem(
                    value: FilterList.bloomberg, child: Text('Bloomberg')),
                const PopupMenuItem(value: FilterList.cnn, child: Text('CNN'))
              ],
              icon: const Icon(
                Icons.more_vert,
              ),
              onSelected: (FilterList item) {
                if (FilterList.bbcnews.name == item.name) {
                  name = 'bbc-news';
                }
                if (FilterList.abcnews.name == item.name) {
                  name = 'abc-news';
                }
                if (FilterList.bloomberg.name == item.name) {
                  name = 'bloomberg';
                }
                if (FilterList.cnn.name == item.name) {
                  name = 'cnn';
                }
                setState(() {
                  NewsViewModel().getHeadlines(name);
                });
              },
            )
          ],
        ),
        body: ListView(
          children: [
            Container(
              height: height * 0.55,
              child: FutureBuilder<NewsChannelHeadlines>(
                  future: newsViewModel.getHeadlines(name),
                  builder: (builder, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: SpinKitCircle(
                          color: Colors.blue,
                          size: 50,
                        ),
                      );
                    } else {
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.articles.length,
                          itemBuilder: (ctx, index) {
                            DateTime dateTime = DateTime.parse(
                                snapshot.data!.articles[index].publishedAt);
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                clipBehavior: Clip.antiAlias,
                                borderRadius: BorderRadius.circular(18),
                                child: Container(
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      SizedBox(
                                        height: height * 0.55,
                                        width: width * 0.9,
                                        child: CachedNetworkImage(
                                          imageUrl: snapshot
                                              .data!.articles[index].urlToImage,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        left: 10,
                                        right: 10,
                                        bottom: 10,
                                        child: ClipRRect(
                                          clipBehavior: Clip.antiAlias,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            height: height * 0.2,
                                            width: width * 0.8,
                                            color: Colors.white,
                                            child: Column(
                                              children: [
                                                Text(
                                                  snapshot.data!.articles[index]
                                                      .title,
                                                  style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                const Spacer(),
                                                Row(
                                                  children: [
                                                    Text(
                                                      snapshot
                                                          .data!
                                                          .articles[index]
                                                          .author,
                                                      textAlign: TextAlign.left,
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                    const Spacer(),
                                                    Text(
                                                      format.format(dateTime),
                                                      textAlign: TextAlign.left,
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    }
                  }),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: height * 0.3,
              child: FutureBuilder(
                  future: NewsFromSourceCategory().getNewsFromSource(name),
                  builder: (builder, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ListView.builder(
                          itemCount: snapshot.data!.articles.length,
                          itemBuilder: (ctx, index) {
                            return Column(
                              children: [
                                Container(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        clipBehavior: Clip.antiAlias,
                                        borderRadius: BorderRadius.circular(16),
                                        child: Container(
                                          height: height * 0.15,
                                          width: width * 0.45,
                                          color: const Color.fromARGB(
                                              255, 242, 241, 241),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Container(
                                            padding: const EdgeInsets.all(10),
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 10,
                                                  width: 150,
                                                  color: const Color.fromARGB(
                                                      255, 242, 241, 241),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                  height: 10,
                                                  width: 150,
                                                  color: const Color.fromARGB(
                                                      255, 242, 241, 241),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                  height: 10,
                                                  width: 150,
                                                  color: const Color.fromARGB(
                                                      255, 242, 241, 241),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                  height: 10,
                                                  width: 150,
                                                  color: const Color.fromARGB(
                                                      255, 242, 241, 241),
                                                ),
                                              ],
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                )
                              ],
                            );
                          });
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.articles.length,
                          itemBuilder: (ctx, index) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (ctx) => NewsDescription(
                                                snapshot.data!.articles[index]
                                                    .urlToImage,
                                                snapshot.data!.articles[index]
                                                    .title,
                                                snapshot.data!.articles[index]
                                                    .publishedAt,
                                                snapshot.data!.articles[index]
                                                    .author!,
                                                snapshot.data!.articles[index]
                                                    .description,
                                                snapshot.data!.articles[index]
                                                    .content,
                                                snapshot.data!.articles[index]
                                                    .source
                                                    .toString())));
                                  },
                                  child: Container(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          clipBehavior: Clip.antiAlias,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          child: Container(
                                            height: height * 0.15,
                                            width: width * 0.45,
                                            color: Colors.black,
                                            child: CachedNetworkImage(
                                              imageUrl: snapshot.data!
                                                  .articles[index].urlToImage!,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(
                                              snapshot
                                                  .data!.articles[index].title,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                )
                              ],
                            );
                          });
                    }
                  }),
            )
          ],
        ));
  }
}
