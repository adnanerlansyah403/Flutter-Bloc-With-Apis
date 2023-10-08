
import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_with_apis/features/articles/models/article_model.dart';
import 'package:flutter_bloc_with_apis/features/articles/repos/articles_repo.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'articles_event.dart';
part 'articles_state.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  ArticlesBloc() : super(ArticlesInitial()) {
    // on<ArticlesEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
    on<ArticlesInitialsFetchEvent>(articlesInitialsFetchEvent);
    on<ArticleAddEvent>(articleAddEvent);
  }

  FutureOr<void> articlesInitialsFetchEvent(ArticlesInitialsFetchEvent event, Emitter<ArticlesState> emit) async {
    emit(ArticlesFetchingLoadingState());
    List<ArticleModel> articles = await ArticlesRepo.fetchArticles();
    emit(ArticleFetchingSuccessfulState(articles: articles));
  }

  FutureOr<void> articleAddEvent(ArticleAddEvent event, Emitter<ArticlesState> emit) async {
    bool success = await ArticlesRepo.addArticle();
    print(success);
    if(success) {
      emit(ArticlesAdditionSuccessState());
    } else {
      emit(ArticlesAdditionErrorState());
    }
  }
}
