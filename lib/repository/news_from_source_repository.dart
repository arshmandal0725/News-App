import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/models/news_from_source.dart';

class NewsFromSourceRepository {
  Future<NewsFromSource> getNewsFromSource(String name) async {
  
    String url =
        'https://newsapi.org/v2/everything?sources=${name}&apiKey=e39a1b24c0d04489b1e1f6512f8f1488';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print(response.body);
      final body = jsonDecode(response.body);
      return NewsFromSource.fromJson(body);
    }
    throw Error();
  }
}
