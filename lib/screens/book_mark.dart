import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tribun_app/controllers/bookmark_controller.dart';
import 'package:tribun_app/models/news_articles.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bookmarkController = Get.find<BookmarkController>();

    return Scaffold(
      backgroundColor: const Color(0xFF0E1A36),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E1A36),
        elevation: 0,
        title: const Text(
          'Bookmark',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              bookmarkController.savedArticles.clear();
              Get.snackbar('Cleared', 'All bookmarks removed');
            },
            icon: const Icon(Icons.delete_outline, color: Colors.white),
          ),
        ],
      ),
      body: Obx(() {
        if (bookmarkController.savedArticles.isEmpty) {
          return const Center(
            child: Text(
              'No saved articles yet',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.builder(
            itemCount: bookmarkController.savedArticles.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // dua kolom
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.74, // biar pas proporsinya
            ),
            itemBuilder: (context, index) {
              final article = bookmarkController.savedArticles[index];
              return _buildBookmarkCard(article);
            },
          ),
        );
      }),
    );
  }

  // ini ui utk tiap card di halaman bookmark ny yh
  Widget _buildBookmarkCard(NewsArticles article) {
    return GestureDetector(
      onTap: () {
        // ngarahin ke detail news 
        Get.toNamed('/news_detail', arguments: article);
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1B325B),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // gambar atasnya
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: article.urlToImage != null
                  ? Image.network(
                      article.urlToImage!,
                      height: 110,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 110,
                        color: Colors.white12,
                        child: const Icon(Icons.broken_image, color: Colors.white54),
                      ),
                    )
                  : Container(
                      height: 110,
                      color: Colors.white12,
                      child: const Icon(Icons.image, color: Colors.white54),
                    ),
            ),

            // konten bawahnya 
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.source?.name ?? 'Unknown Source',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white54,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      article.title ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
