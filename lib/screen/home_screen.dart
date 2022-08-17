import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:the_news/controller/home_controller.dart';
import 'package:the_news/enum/error_type.dart';
import 'package:the_news/model/news_model.dart';
import 'package:the_news/screen/widget/news_catogry.dart';

import '../model/category_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        child: GetX<HomeController>(builder: (cont) {
          if (cont.error.value.errorType == ErrorType.internet) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Daily News',
                        style: TextStyle(
                          fontSize: 18.sp,
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
                      child: Hero(
                        tag: 'iconSearch',
                        child: Icon(
                          Icons.search,
                          size: 25.w,
                        ),
                      ),
                    ),
                    SizedBox(width: 15.w),
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => SettingsPage(),
                        //   ),
                        // );
                      },
                      child: Icon(
                        Icons.settings,
                        size: 25.w,
                      ),
                    ),
                  ],
                ),
                Text(
                  strToday,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 15.h),
                CategoryNews(listCategories: listCategories),
                if (cont.categoryNewsData.value.articles.isNotEmpty)
                  Expanded(
                      child: ListView.builder(
                          itemCount:
                              cont.categoryNewsData.value.articles.length,
                          itemBuilder: (context, index) {
                            Article newsData =
                                cont.categoryNewsData.value.articles[index];

                            String publishedAt = DateFormat('dd,MMM yyyy').format(newsData.publishedAt);
                            
                            return GestureDetector(
                              onTap: () async {},
                              child: SizedBox(
                                // height: 200.w,
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 5
                                    )]
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(8.0),
                                            child:
                                            // (newsData.url)
                                            CachedNetworkImage(
                                              imageUrl: newsData.urlToImage ?? "",
                                              fit: BoxFit.cover,
                                              width: 70.w,
                                              height: 70.w,
                                              placeholder: (context, url) {
                                                return ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8.0),
                                                  child: Image.asset(
                                                    'assets/images/img_placeholder.jpg',
                                                    fit: BoxFit.cover,
                                                    width: 200.w,
                                                    height: 200.w,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  newsData.title ?? "",
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 16.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5.w),
                                      Row(
                                        children: [
                                          Text("Author: ",style: TextStyle(
                                            color: Colors.black
                                          ),),
                                          Text(
                                            newsData.author ?? "",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 13.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text("Publish Date: ",style: TextStyle(
                                              color: Colors.black
                                          )),
                                          Text(
                                            publishedAt,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 13.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text("source: ",style: TextStyle(
                                              color: Colors.black
                                          )),
                                          Text(
                                            newsData.source?.name ?? "",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 13.sp,
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
          );
        }),
      ),
    );
  }
}
