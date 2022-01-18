import 'package:flutter/cupertino.dart';
import 'package:techfeed/feed_fetchers/fetcher.dart';
import 'package:webfeed/domain/rss_item.dart';

class MultiFeedFetcher extends ChangeNotifier {
  late List<String> sources;
  late Map<RSSFetcher, bool> fetchers = {};
  List<RssItem> items = [];
  MultiFeedFetcher(this.sources) {
    for (final source in sources) {
      final fetcher = RSSFetcher(source);
      fetcher.addListener(() {
        _updateItems(fetcher);
      });
      fetchers[fetcher] = false;
    }
  }

  void updateAll() {
    fetchers = {};
    items = [];
    for (final source in sources) {
      final fetcher = RSSFetcher(source);
      fetcher.addListener(() {
        _updateItems(fetcher);
      });
      fetchers[fetcher] = false;
    }
  }

  _updateItems(RSSFetcher fetcher) {
    if (fetcher.success) {
      items.addAll(fetcher.feed.items ?? []);

      items.sort((a, b) {
        if (a.pubDate == null) return 1;
        if (b.pubDate == null) return -1;
        return b.pubDate!.compareTo(a.pubDate!);
      });
      notifyListeners();
    }
  }

  bool get everyFetcherSuccess {
    return fetchers.values.every((value) => value);
  }
}
