import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/models/news_channel_headlines.dart';

class NewsRepository {
  Future<NewsChannelHeadlines> getHeadlines(String name) async {
  
    String url =
        'https://newsapi.org/v2/top-headlines?sources=${name}&apiKey=e39a1b24c0d04489b1e1f6512f8f1488';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print(response.body);
      final body = jsonDecode(response.body);
      return NewsChannelHeadlines.fromJson(body);
    }
    throw Error();
  }
}
