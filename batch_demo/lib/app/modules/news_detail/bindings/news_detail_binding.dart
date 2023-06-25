import 'package:get/get.dart';

import '../controllers/news_detail_controller.dart';

class NewsDetailBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut<NewsDetailController>(
        () => NewsDetailController(),
        tag: Get.parameters['id'],
      )
    ];
  }
}
