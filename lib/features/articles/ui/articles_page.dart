import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_with_apis/features/articles/bloc/articles_bloc.dart';

class ArticlesPage extends StatefulWidget {
  const ArticlesPage({super.key});

  @override
  State<ArticlesPage> createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  final ArticlesBloc articlesBloc = ArticlesBloc();

  @override
  void initState() {
    articlesBloc.add(ArticlesInitialsFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Articles Page'),
      ),
      body: BlocConsumer<ArticlesBloc, ArticlesState>(
        bloc: articlesBloc,
        listenWhen: (previous, current) => current is ArticlesActionState,
        buildWhen: (previous, current) => current is !ArticlesActionState,
        listener: (context, state) {
          if(state is ArticlesAdditionSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Article was added')));
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case ArticlesFetchingLoadingState:
              return const Center(child: CircularProgressIndicator());
            case ArticleFetchingSuccessfulState:
              final successState = state as ArticleFetchingSuccessfulState;

              return Container(
                child: ListView.builder(
                  itemCount: successState.articles.length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.grey.shade200,
                      padding: const EdgeInsets.all(16.0),
                      margin: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(successState.articles[index].title),
                          Text(successState.articles[index].body),
                        ],
                      ),
                    );
                  },
                ),
              );
            default:
              return SizedBox();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          articlesBloc.add(ArticleAddEvent());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
