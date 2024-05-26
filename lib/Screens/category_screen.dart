import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/view_model/news_category_viewmodel.dart';

class NewsCategoryScreen extends StatefulWidget {
  const NewsCategoryScreen({super.key});

  @override
  State<NewsCategoryScreen> createState() => _NewsCategoryScreenState();
}

List<String> categoryList = [
  'general',
  'entertainment',
  'health',
  'sports',
  'business',
  'technology'
];

String name = 'general';
var _selectedIndex = 0;

class _NewsCategoryScreenState extends State<NewsCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'News',
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
        ),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categoryList.length,
                      itemBuilder: (ctx, index) {
                        return Row(
                          children: [
                            ClipRRect(
                              child: InkWell(
                                onTap: () {
                                  name = categoryList[index];
                                  _selectedIndex = index;
                                  setState(() {
                                    NewsCategoryViewModel()
                                        .getCategoryData(name);
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(11),
                                  decoration: BoxDecoration(
                                      color: (_selectedIndex == index)
                                          ? const Color.fromARGB(
                                              255, 188, 213, 234)
                                          : const Color.fromARGB(
                                              255, 188, 186, 186),
                                      borderRadius: BorderRadius.circular(22)),
                                  child: Center(
                                    child: Text(
                                      categoryList[index],
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            )
                          ],
                        );
                      }),
                ),
              ),
              Expanded(
                  flex: 9,
                  child: Container(
                    child: FutureBuilder(
                        future: NewsCategoryViewModel().getCategoryData(name),
                        builder: (builder, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: SpinKitCircle(
                                color: Colors.blue,
                                size: 60,
                              ),
                            );
                          } else {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: ListView.builder(
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
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                child: Container(
                                                  height: height * 0.25,
                                                  width: width * 0.4,
                                                  color: Colors.black,
                                                  child: CachedNetworkImage(
                                                    imageUrl: snapshot
                                                        .data!
                                                        .articles[index]
                                                        .urlToImage!,
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
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Text(
                                                    snapshot.data!
                                                        .articles[index].title,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        )
                                      ],
                                    );
                                  }),
                            );
                          }
                        }),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
