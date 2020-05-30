import 'package:flutter/material.dart';
import 'package:pagination_view/pagination_view.dart';
import 'package:provider/provider.dart';
import 'package:labs_technical_test/provider/repoProvider.dart';
import 'package:labs_technical_test/model/repo.dart';
import 'package:labs_technical_test/ui/widgets/repoWidget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PaginationViewType paginationViewType;
  List<Repo> _initialRepo = [];
  @override
  void initState() {
    //  _getInitialRepo();
    paginationViewType = PaginationViewType.listView;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final repoProvider = Provider.of<RepoProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Flutter Repos",
        ),
        centerTitle: true,
      ),
      body: PaginationView<Repo>(
        // preloadedItems: [],
        paginationViewType: paginationViewType,
        itemBuilder: (BuildContext context, Repo repo, int index) => RepoWidget(
          repo: repo,
        ),
        pageFetch: repoProvider.getRepos,
        onError: (dynamic error) => Center(
          child: Text('Some error occured'),
        ),
        onEmpty: Center(
          child: Text('Sorry! This  List is empty'),
        ),
        bottomLoader: Center(
          child: CircularProgressIndicator(),
        ),
        initialLoader: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
