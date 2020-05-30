import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:labs_technical_test/model/repo.dart';

int page = -1;

class RepoProvider with ChangeNotifier {
  List<Repo> _repos = [];
  List<Repo> get repos {
    return [..._repos];
  }

  Future<List<Repo>> getRepos(int offset) async {
    page++;
    try {
      final String repoUrl =
          "https://api.github.com/search/repositories?q=flutter+language:dart&page=$page&per_page=10";
      final responseData = await http.get(repoUrl);
      if (responseData.statusCode == 200) {
        Iterable extractedRepoList = json.decode(responseData.body)['items'];
        if (extractedRepoList != null) {
          _repos = Repo.repoListFromJson(extractedRepoList);
          return _repos;
        }
      }
      return [];
    } catch (ex) {
      return null;
    }
  }
}
