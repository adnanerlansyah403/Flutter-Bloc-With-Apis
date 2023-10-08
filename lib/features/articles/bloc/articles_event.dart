part of 'articles_bloc.dart';

@immutable
sealed class ArticlesEvent {}

class ArticlesInitialsFetchEvent extends ArticlesEvent {}

class ArticleAddEvent extends ArticlesEvent {}