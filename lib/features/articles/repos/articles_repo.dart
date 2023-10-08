import 'package:flutter_bloc_with_apis/features/articles/models/article_model.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class ArticlesRepo {
  
  static Future<List<ArticleModel>> fetchArticles() async {
    var client = http.Client();
    List<ArticleModel> articles = [];
    try {
      var response = await client.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/'));
      List result = jsonDecode(response.body);
      for (var i = 0; i < result.length; i++) {
        ArticleModel article = ArticleModel.fromMap(result[i] as Map<String, dynamic>);
        articles.add(article);
      }

      return articles;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
  
  static Future<bool> addArticle() async {
    var client = http.Client();
    try {
      var response = await client.post(Uri.parse('https://jsonplaceholder.typicode.com/posts/'), 
        body: {
          'title': 'Aksa Kown Res So Purpose',
          "body": "Lorem Ipsum is simply dummy text and cannot be used in real life",
          "userId": "34"
        }
      );

      if(response.statusCode >= 200 && response.statusCode <= 300) {
        return true;
      }
      return false;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

}