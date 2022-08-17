import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_news/controller/home_controller.dart';
import 'package:the_news/enum/error_type.dart';

import '../../model/category_model.dart';

class CategoryNews extends StatefulWidget {
  final List<CategoryModel> listCategories;

  CategoryNews({
    required this.listCategories,
  });

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetX<HomeController>(
      builder: (cont) {

        if(cont.error.value.errorType == ErrorType.internet){
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Column(
          children: [
            SizedBox(
              height: 35.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  var itemCategory = widget.listCategories[index];
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          cont.selectedCategory.value = index;
                          await cont.getCategoryNews(category: itemCategory.title);
                        },
                        child: Container(
                           margin : EdgeInsets.only(left: 5),
                        padding: itemCategory.title.toLowerCase() == 'all' ? const EdgeInsets.symmetric(horizontal: 25,vertical: 10) : EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: itemCategory.title.toLowerCase() == 'all' ? const Color(0xFFBBCDDC) : null,
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
                itemCount: widget.listCategories.length,
              ),
            ),


          ],
        );
      }
    );
  }
}