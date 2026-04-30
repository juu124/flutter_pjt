import 'package:flutter/material.dart';

import '../../models/news_article.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsItemWidget extends StatelessWidget {
  NewsArticle article;

  NewsItemWidget(this.article);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: article.urlToImage != null
          ? Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(article.urlToImage!),
                  fit: BoxFit.cover,
                ),
              ),
            )
          : Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey.shade300,
              ),
            ),
      title: Text(article.title, maxLines: 2, overflow: TextOverflow.ellipsis),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            article.descrption,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4), // SizedBox는 리빌드 될 필요 x
          Text(
            article.source ?? '',
            style: TextStyle(fontSize: 12, color: Colors.blue),
          ),
        ],
      ),
      onTap: () {
        debugPrint('아이템 위젯 내부에서 클릭 감지: ${article.url}');
        _launchUrl(article.url);
      },
    );
  }

  // news 웹 사이트 페이지 열기
  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);

    try {
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      print('URL 실행 에러: $e');
    }
  }
}
