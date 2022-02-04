import 'package:flutter/material.dart';

import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class RSSFetcher extends ChangeNotifier {
  final String url;
  late RssFeed _feed;
  bool success = false;

  RSSFetcher(this.url) {
    fetch();
  }

  void notify() {
    notifyListeners();
  }

  RssFeed get feed => _feed;

  Future<void> fetch() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      _feed = RssFeed.parse(response.body);
      success = true;
      notifyListeners();
    }
  }

  void openLink(int index) {
    final item = _feed.items![index];
    final url = item.link;
    launch(url as String);
  }
}
