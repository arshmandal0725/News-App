import 'package:news_app/models/news_channel_headlines.dart';
import 'package:news_app/repository/news_repository.dart';

class NewsViewModel {
  final _rep = NewsRepository();

  Future<NewsChannelHeadlines> getHeadlines(String name) async {
    final response = await _rep.getHeadlines(name);
    return response;
  }
}
