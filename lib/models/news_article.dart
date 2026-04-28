// 뉴스 기사 하나 추상화 dto
class NewsArticle {
  String title;
  String descrption;
  String url;
  String? urlToImage;
  String publishedAt;
  String? source;

  NewsArticle({
    required this.title,
    required this.descrption,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    this.source,
  });

  // 아래 작업이 귀잖다면 jsonSerialigation을 사용하면 된다.
  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? '',
      descrption: json['description'] ?? '',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'] ?? '',
      source: json['source']?['name'],
    );
  }
}
