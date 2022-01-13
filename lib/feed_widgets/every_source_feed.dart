import 'package:flutter/material.dart';
import 'package:techfeed/feed_fetchers/multi_feed_fetcher.dart';

import 'feed_card.dart';

class MultiFeedWidget extends StatelessWidget {
  final List<String> sources;
  const MultiFeedWidget(this.sources, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var animation = MultiFeedFetcher(sources);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tech Feed'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              animation.updateAll();
            },
          ),
        ],
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return ListView.builder(
              itemCount: animation.items.length,
              itemBuilder: (context, index) {
                return FeedCard(
                  animation.items[index],
                  showSource: true,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
