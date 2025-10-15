import 'package:get/get.dart';
import 'package:tribun_app/models/news_articles.dart';
import 'package:tribun_app/services/new_services.dart';
import 'package:tribun_app/utils/constants.dart';

class NewsController extends GetxController{
  // untuk memproses request yang sudah dibuat oleh news services.
  final NewsServices _newsServices = NewsServices();

  // observable variables atau variable yang bisa di berubah.
  final _isloading = false.obs; // apakah aplikasi sedang memuat berita.
  final _articles = <NewsArticles>[].obs; //untuk menampilkan daftar berita yang sudah atau berhasil didapat.
  final _selectedCategory = 'general'.obs; // untuk ngehandle category yg sedang dipilih atau yg akan muncul di home screen
  final _error = ''.obs; // kalau ada kesalahan, pesan error akan disimpan disini 

  // getters
  // getter ini, seperti jendela untuk melihat isi variable yg sudah kita buat atau yg sudah di definisikan
  // kemudian dengan ini , UI bisa melihat dengan mudah melihat dari controller
  bool get isloading => _isloading.value;
  List<NewsArticles> get articles => _articles;
  String get selectedCategory => _selectedCategory.value;
  String get error => _error.value;
  List<String> get categories => Constants.categories;

  //begitu aplikasi dibuka , aplikasi langsung menanpilkan 
  //berita utama dari endpoint top-headlines
  // TODO: fetching data dari endpoint top-headlines

  Future<void> fecthTobHeadlines({String? category}) async{
    // blok ini akan di jalankan ketika rest API berhasil berkomunikasi dengan serve
    try {
      _isloading.value = true;
      _error.value = '';

      final response = await _newsServices.getTopHeadlines(
        category: category ?? _selectedCategory.value,
      );

      _articles.value = response.articles;
    } catch (e) {
      _error.value = e.toString();
      Get.snackbar(
        'Error',
        'Failed to load news: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
      // finally akan tetap diexecute setelah salah satu dari blok 
    } finally{
      _isloading.value = false; 
    }
  }
  
  Future<void> refreshNews() async{
    await fecthTobHeadlines();
  }

  void selectCategory(String category){
    if (_selectedCategory.value != category) {
      _selectedCategory.value = category;
      fecthTobHeadlines(category: category);
    }
  }
  Future<void> searchNews(String query) async {
    if (query.isEmpty) return;

    try {
      _isloading.value = true;
      _error.value = '';

      final response = await _newsServices.searchNews(query: query);
      _articles.value = response.articles;
    } catch (e) {
      _error.value = e.toString();
      Get.snackbar(
        'Error',
        'Failed to search news: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM
      );
    }finally {
      _isloading.value = false;
    }
  }
}