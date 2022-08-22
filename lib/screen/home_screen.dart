import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_news/model/news_model.dart';
import '../api_helper/data.dart';
import '../api_helper/new_appi_helper.dart';
import '../model/category_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    NewsModel? newsData = await NewsApiHelper.newsApiHelper
        .getCategoryNews(category: "All");

    if (newsData != null) {
      setState(() {
        // ApiData.allNewsData.
        // allNewsData = newsData;
        ApiData.allNewsData = newsData;
      });
    }
  }

  String strToday = DateFormat('EEEE, MMM dd, yyyy').format(DateTime.now());

  List<CategoryModel> listCategories = [
    CategoryModel(image: '', title: 'All'),
    CategoryModel(image: 'assets/images/img_business.png', title: 'Business'),
    CategoryModel(
        image: 'assets/images/img_entertainment.png', title: 'Entertainment'),
    CategoryModel(image: 'assets/images/img_health.png', title: 'Health'),
    CategoryModel(image: 'assets/images/img_science.png', title: 'Science'),
    CategoryModel(image: 'assets/images/img_sport.png', title: 'Sports'),
    CategoryModel(
        image: 'assets/images/img_technology.png', title: 'Technology'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  const Expanded(
                    child: Text(
                      'Daily News',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => SearchPage()),
                      // );
                    },
                    child: const Hero(
                      tag: 'iconSearch',
                      child: Icon(
                        Icons.search,
                        size: 25,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.settings,
                      size: 25,
                    ),
                  ),
                ],
              ),
              Text(
                strToday,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 15),
              categoryWidget(listCategories: listCategories),
              if (ApiData.allNewsData.articles.isNotEmpty)
                Expanded(
                    child: ListView.builder(
                        itemCount: ApiData.allNewsData.articles.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          Article newsData =
                              ApiData.allNewsData.articles[index];
                          print(
                              "${ApiData.allNewsData.articles.length} Length");
                          print("${ApiData.allNewsData.totalResults} Length");

                          String publishedAt = DateFormat('dd,MMM yyyy')
                              .format(newsData.publishedAt);

                          return GestureDetector(
                            onTap: () async {},
                            child: SizedBox(
                              // height: 200.w,
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 5)
                                    ]),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: (newsData.urlToImage != null)
                                                ? Image.network(
                                                    newsData.urlToImage!,
                                                    height: 70,
                                                    width: 100,
                                                    fit: BoxFit.fill,
                                                  )
                                                : Image.asset(
                                                    "assets/images/img_placeholder.jpg",
                                                    scale: 50,
                                                  )),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                newsData.title ?? "",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Author: ",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Expanded(
                                          child: Text(
                                            newsData.author ?? "",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text("Publish Date: ",
                                            style:
                                                TextStyle(color: Colors.black)),
                                        Text(
                                          publishedAt,
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text("source: ",
                                            style:
                                                TextStyle(color: Colors.black)),
                                        Text(
                                          newsData.source?.name ?? "",
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }))
            ],
          ),
        ),
      ),
    );
  }

  categoryWidget({required List<CategoryModel> listCategories}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          SizedBox(
            height: 35,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var itemCategory = listCategories[index];
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        // cont.selectedCategory.value = index;
                        setState(() {
                          ApiData.selectedCategory = itemCategory.title;
                        });
                        NewsModel? newsData = await NewsApiHelper.newsApiHelper
                            .getCategoryNews(category: itemCategory.title);

                        print("${newsData?.articles.length}");
                        if (newsData != null) {
                          setState(() {
                            ApiData.allNewsData = newsData;
                          });
                        }
                        setState(() {});
                        // await cont.getCategoryNews(category: itemCategory.title);
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 5),
                        padding: itemCategory.title.toLowerCase() == 'all'
                            ? const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10)
                            : EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: itemCategory.title.toLowerCase() == 'all'
                              ? const Color(0xFFBBCDDC)
                              : null,
                          borderRadius: BorderRadius.circular(10),
                          image: itemCategory.title.toLowerCase() == 'all'
                              ? null
                              : DecorationImage(
                                  image: AssetImage(
                                    itemCategory.image,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                        ),
                        child: Center(
                          child: Text(
                            itemCategory.title,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
              itemCount: listCategories.length,
            ),
          ),
        ],
      ),
    );
  }
}
