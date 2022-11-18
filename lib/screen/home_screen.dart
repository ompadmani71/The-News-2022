import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:the_news/controller/home_controller.dart';
import 'package:the_news/controller/news_controller.dart';
import 'package:the_news/model/news_model.dart';
import 'package:the_news/provider/theam_provider.dart';
import 'package:the_news/screen/detail_screen.dart';
import '../model/category_model.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.find();
  NewsController newsController = Get.find();

  List<CategoryModel> listCategories = [
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
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await newsController.getHeadline();
      await newsController.getCategoryNews(
          category:
              listCategories[homeController.selectedCategory.value].title);
    });
  }

  String strToday = DateFormat('EEEE, MMM dd, yyyy').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: GetBuilder<NewsController>(builder: (cont) {
        return SafeArea(
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
                    Consumer<ThemeProvider>(builder: (BuildContext context, value, Widget? child) {
                     return GestureDetector(
                        onTap: () {
                          value.changeTheme();

                          // print("${ Provider.isLight}");
                          // setState(() {});
                        },
                        child: Icon(
                          value.isLight
                              ? Icons.light_mode_outlined
                              : Icons.dark_mode_outlined,
                        ),
                      );
                    },)
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
                // categoryWidget(listCategories: listCategories),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    CarouselSlider(
                        options: CarouselOptions(
                          height: size.height * 0.23,
                          viewportFraction: 0.9,
                          onPageChanged: (i, _) {
                            homeController.carouselSliderIndex(i);
                          },
                        ),
                        items: cont.headLineNews.map((article) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(DetailScreen(article: article));
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Stack(
                                  children: [
                                    SizedBox(
                                        height: size.height * 0.23,
                                        child: Image.network(
                                            article.urlToImage ?? "",
                                            fit: BoxFit.cover)),
                                    Container(
                                      color: Colors.black26,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            article.title ?? "",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12),
                                          ),
                                          Text(
                                            "Source: ${article.source!.name}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList()),
                    Positioned(
                      bottom: 5,
                      child: Obx(() => Row(
                              children: cont.headLineNews.map((article) {
                            return Padding(
                              padding: const EdgeInsets.all(5),
                              child: CircleAvatar(
                                radius: 4,
                                backgroundColor:
                                    (homeController.carouselSliderIndex.value ==
                                            cont.headLineNews.indexOf(article)
                                        ? Colors.teal
                                        : Colors.grey),
                              ),
                            );
                          }).toList())),
                    )
                  ],
                ),
                SizedBox(height: 20),
                if(cont.categoryNews.isNotEmpty)
                SizedBox(
                    height: size.height * 0.07,
                    child: ListView.builder(
                        itemCount: listCategories.length,
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          CategoryModel itemCategory = listCategories[index];
                          return GestureDetector(
                            onTap: () async {
                              homeController.selectedCategory(index);
                              await cont.getCategoryNews(
                                  category: listCategories[index].title);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: size.height * 0.05,
                                  margin: const EdgeInsets.only(left: 5),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    // color: itemCategory.title.toLowerCase() ==
                                    //     'all'
                                    //     ? const Color(0xFFBBCDDC)
                                    //     : null,
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                      image: AssetImage(
                                        itemCategory.image,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      itemCategory.title,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                if (homeController.selectedCategory.value ==
                                    index)
                                  Container(
                                    height: 3,
                                    width: size.width * 0.04,
                                    margin: EdgeInsets.only(top: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(5)),
                                  )
                              ],
                            ),
                          );
                        })),

                (cont.categoryNews.isEmpty)
                    ? const Expanded(
                        // flex: 18,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Expanded(
                        // flex: 18,
                        child: ListView.builder(
                            itemCount: cont.categoryNews.length,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              Article newsData = cont.categoryNews[index];

                              String publishedAt = DateFormat('dd,MMM yyyy')
                                  .format(newsData.publishedAt);

                              return GestureDetector(
                                onTap: () async {
                                  Get.to(DetailScreen(article: cont.categoryNews[index],));
                                },
                                child: SizedBox(
                                  child: Container(
                                    padding: const EdgeInsets.all(15),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              blurRadius: 5)
                                        ]),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: (newsData.urlToImage !=
                                                        null)
                                                    ? CachedNetworkImage(
                                                        height:
                                                            size.width * 0.18,
                                                        width: size.width * 0.3,
                                                        imageUrl: newsData
                                                            .urlToImage!,
                                                        fit: BoxFit.cover,
                                                        placeholder:
                                                            (context, _) {
                                                          return Image.asset(
                                                              "assets/images/img_placeholder.jpg");
                                                        },
                                                      )
                                                    // Image.network(
                                                    //         newsData.urlToImage!,
                                                    //         height: 70,
                                                    //         width: 100,
                                                    //         fit: BoxFit.fill,
                                                    //       )
                                                    : Image.asset(
                                                        "assets/images/img_placeholder.jpg",
                                                        scale: 5,
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
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            Expanded(
                                              child: Text(
                                                newsData.author ?? "-",
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
                                                style: TextStyle(
                                                    color: Colors.black)),
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
                                                style: TextStyle(
                                                    color: Colors.black)),
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
        );
      }),
    );
  }

// categoryWidget({required List<CategoryModel> listCategories}) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 10),
//     child: Column(
//       children: [
//         SizedBox(
//           height: 35,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemBuilder: (context, index) {
//               var itemCategory = listCategories[index];
//               return Column(
//                 children: [
//                   GestureDetector(
//                     onTap: () async {
//                       // cont.selectedCategory.value = index;
//                       setState(() {
//                         ApiData.selectedCategory = itemCategory.title;
//                       });
//                       News? newsData = await NewsApiHelper.newsApiHelper
//                           .getCategoryNews(category: itemCategory.title);
//
//                       print("${newsData?.articles.length}");
//                       if (newsData != null) {
//                         setState(() {
//                           ApiData.allNewsData = newsData;
//                         });
//                       }
//                       setState(() {});
//                       // await cont.getCategoryNews(category: itemCategory.title);
//                     },
//                     child: Container(
//                       margin: EdgeInsets.only(left: 5),
//                       padding: itemCategory.title.toLowerCase() == 'all'
//                           ? const EdgeInsets.symmetric(
//                               horizontal: 25, vertical: 10)
//                           : EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         color: itemCategory.title.toLowerCase() == 'all'
//                             ? const Color(0xFFBBCDDC)
//                             : null,
//                         borderRadius: BorderRadius.circular(10),
//                         image: itemCategory.title.toLowerCase() == 'all'
//                             ? null
//                             : DecorationImage(
//                                 image: AssetImage(
//                                   itemCategory.image,
//                                 ),
//                                 fit: BoxFit.cover,
//                               ),
//                       ),
//                       child: Center(
//                         child: Text(
//                           itemCategory.title,
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             },
//             itemCount: listCategories.length,
//           ),
//         ),
//       ],
//     ),
//   );
// }
}
