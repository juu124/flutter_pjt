import 'package:flutter/material.dart';
import '../models/news_article.dart';
import '../services/news_service.dart';

// 네트워킹 데이터가 앱의 상태 데이터로 가정해서 코딩
class NewsProvider with ChangeNotifier{
  NewsService _newsService = NewsService();
  List<NewsArticle> _articles = [];
  bool _isloading = false;
  String? _error;
  String? _destinationName;

  List<NewsArticle> get articles => _articles;
  bool get isLoading => _isloading;
  String? get error => _error;
  String? get destinationName => _destinationName;

  Future<void> fetchNews(String destinationName) async {
    _isloading = true;
    _error = null;
    _destinationName = destinationName;
    notifyListeners();

    try {
      // 네트워킹 시도
      _articles = await _newsService.getNews(_destinationName);
    } catch(e) {
      _error = e.toString();
    } finally {
      _isloading = false;
      notifyListeners();
    }
  }
}