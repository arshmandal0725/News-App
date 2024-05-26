import 'package:news_app/models/news_from_source.dart';
import 'package:news_app/repository/news_from_source_repository.dart';


class NewsFromSourceCategory {
  final _rep = NewsFromSourceRepository();

  Future<NewsFromSource> getNewsFromSource(String name) async {
    final response = await _rep.getNewsFromSource(name);
    return response;
  }
}
