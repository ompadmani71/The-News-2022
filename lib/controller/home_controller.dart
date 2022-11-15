import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController{

  RxInt selectedCategory = 0.obs;
  RxInt carouselSliderIndex = 0.obs;

  Future<void> loadWebPage({required String url}) async {

    // await launchUrl(Uri.parse(url));

    if(await launchUrl(Uri.parse(url))){
      throw 'Could not launch $url';
    }
  }

}