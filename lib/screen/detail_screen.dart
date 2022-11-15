import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:the_news/controller/home_Controller.dart';
import 'package:the_news/model/news_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.article}) : super(key: key);

  final Article article;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {


  @override
  Widget build(BuildContext context) {
    String publishAt =
        DateFormat('EEEE, MMM dd, yyyy').format(widget.article.publishedAt);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: size.width * 0.1,
                height: size.width * 0.1,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(Icons.keyboard_arrow_left),
                ),
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  height: size.height * 0.25,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  imageUrl: widget.article.urlToImage ?? "",
                  placeholder: (context, _) {
                    return Image.asset(
                      "assets/images/img_placeholder.jpg",
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              Text(
                "${widget.article.title}.",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Text(
                "Publish: $publishAt",
                style: const TextStyle(),
              ),
              Text(
                "Author: ${widget.article.author ?? "-"}",
                style: const TextStyle(),
              ),
              SizedBox(height: size.height * 0.05),
              const Text(
                "About",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Text(
                widget.article.description ?? "description",
              ),
              SizedBox(height: size.height * 0.03),
              const Text(
                "Know More",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Text(
                "${widget.article.content ?? "content"}.",
              ),
              GestureDetector(
                onTap: () async{
                  if(await launchUrl(Uri.parse(widget.article.url ?? ""))){
                  throw 'Could not launch ${widget.article.url ?? ""}';
                  }
                },
                child: Text(
                  "click here to view all",
                  style: const TextStyle(color: Colors.blueAccent,fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
