import 'package:flutter/material.dart';

import '../feed_fetchers/fetcher.dart';
import 'card/feed_card.dart';

class FeedWidget extends StatelessWidget {
  final String source;
  final String title;
  late final RSSFetcher _fetcher;

  FeedWidget(this.title, this.source, {Key? key}) : super(key: key) {
    _fetcher = RSSFetcher(source);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _fetcher.success = false;
              _fetcher.notifyListeners();
              _fetcher.fetch();
            },
          ),
        ],
      ),
      body: AnimatedBuilder(
          animation: _fetcher,
          builder: (context, snapshot) {
            return _fetcher.success && _fetcher.feed.items != null
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: _fetcher.feed.items?.length,
                    itemBuilder: (context, index) {
                      return FeedCard(_fetcher.feed.items![index]);
                    },
                  )
                : const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
