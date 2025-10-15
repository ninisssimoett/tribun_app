import 'dart:convert';

import 'package:tribun_app/models/news_response.dart';
import 'package:tribun_app/utils/constants.dart';
// maksdunya adalah mendefinisikan sebuah package atau library menjadi sebuah variable secara langsung.
import 'package:http/http.dart' as http;

class NewsServices {
  static const String _baseUrl = Constants.baseURL;
  static final String _apikey = Constants.apiKey;

  // fungsi yang bertujuan untuk membuat request GET ke server.
  Future<NewsResponse> getTopHeadlines({
    String country = Constants.defaultCountry,
    String? category,
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final Map<String,String> queryParams = {
        'apiKey':_apikey,
        'country':country,
        'page':page.toString(),
        'pageSize':pageSize.toString()
      };

      // statement yang akan dijalankan ketika category tidak kosong.
      if (category != null && category.isNotEmpty ) {
        queryParams['category'] = category;
      }
      //berfungsi untuk parsing data dari json ke UI
      // simpel nya kita daftarin baseURL + endpoint yang akan digunakan.
      final uri = Uri.parse('$_baseUrl${Constants.topHeadLines}')
      .replace(queryParameters: queryParams);

      // untuk menyimpan respon yg diberikan oleh server.
      final response = await http.get(uri);

      // kode yang dijalankan jika request ke API success
      if (response.statusCode == 200) {
        // untuk mengubah data dari json ke bahasa dart.
        final jsonData = json.decode(response.body);
        return NewsResponse.fromJson(jsonData);
        // kode yang akan dijalankan jika request ke API gagal atau status http != 200
      } else {
        throw Exception('failed to load news, please try again later.');
      }
      // kode yang akan dijalankan ketika terjadi error lain, selain yg sudah dijalankan diatas.
    } catch (e) {
     throw Exception('Anouther problem occurs, please try again later');
    }
  }

  Future<NewsResponse> searchNews({
    required String query,    // ini adalah nilai yang dimasukan ke kolom pencarian.
    int page = 1,  // untuk mendefinisikan halaman berita ke berapa.
    int pagesize = 20, // berapa banyak berita yang mau ditampilkan ketika sekali proses rendering data.
    String? sortBy, 
  }) async{
    try {
      final Map<String, String> queryParams = {
        'apiKey': _apikey,
        'q': query,
        'page':page.toString(),
        'pagesize':pagesize.toString()
      };

      if (sortBy != null && sortBy.isNotEmpty) {
        queryParams['sortBy'] = sortBy;
      }

      final uri = Uri.parse('$_baseUrl ${Constants.everything}')
      .replace(queryParameters: queryParams);

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return NewsResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to load news, please try again later.');
      }
    } catch (e) {
      throw Exception('Another problem occurs, please try again later.');
    }
  }
}