import 'package:get/get.dart';
import 'package:tribun_app/models/news_articles.dart';

class BookmarkController extends GetxController {
  var savedArticles = <NewsArticles>[].obs;

  void toggleBookmark(NewsArticles article) {
    if (savedArticles.contains(article)) {
      savedArticles.remove(article);
      Get.snackbar('Removed', 'You removed this article from bookmarks');
    } else {
      savedArticles.add(article);
      Get.snackbar('Saved', 'You saved this article!');
    }
  }
}
