part of 'articles_bloc.dart';

@immutable
sealed class ArticlesState {}

abstract class ArticlesActionState extends ArticlesState {}

final class ArticlesInitial extends ArticlesState {}

class ArticlesFetchingLoadingState extends ArticlesState {}

class ArticlesFetchingErrorState extends ArticlesState {}

class ArticleFetchingSuccessfulState extends ArticlesState {
  final List<ArticleModel> articles;

  ArticleFetchingSuccessfulState({required this.articles});
}

class ArticlesAdditionSuccessState extends ArticlesActionState {}

class ArticlesAdditionErrorState extends ArticlesActionState {}