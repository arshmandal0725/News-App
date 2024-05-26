import 'package:news_app/models/news_category.dart';
import 'package:news_app/repository/news_category_repository.dart';


class NewsCategoryViewModel {
  final _rep = NewsCategoryRepository();

  Future<NewsCategory> getCategoryData(String name) async {
    final response = await _rep.getCategoryData(name);
    return response;
  }
}
