import 'package:flutter/material.dart';
import 'package:webfeed/domain/rss_item.dart';

import '../feed_fetchers/fetcher.dart';
import 'card/feed_card.dart';

class FeedWidget extends StatefulWidget {
  final String source;
  final String title;
  late final RSSFetcher _fetcher;

  FeedWidget(this.title, this.source, {Key? key}) : super(key: key) {
    _fetcher = RSSFetcher(source);
  }

  @override
  State<FeedWidget> createState() => _FeedWidgetState();
}

class _FeedWidgetState extends State<FeedWidget> {
  bool userIsWriting = false;
  String filter = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Container(
              constraints: const BoxConstraints(maxWidth: 150),
              child: !userIsWriting
                  ? IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        setState(() {
                          userIsWriting = true;
                        });
                      },
                    )
                  : TextField(
                      decoration: const InputDecoration(
                        hintText: 'Filter',
                      ),
                      onChanged: (value) {
                        setState(() {
                          filter = value;
                        });
                      },
                      onEditingComplete: () {
                        setState(() {
                          userIsWriting = false;
                        });
                      },
                    )),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              widget._fetcher.success = false;
              widget._fetcher.notify();
              widget._fetcher.fetch();
            },
          ),
        ],
      ),
      body: AnimatedBuilder(
          animation: widget._fetcher,
          builder: (context, snapshot) {
            return widget._fetcher.success && widget._fetcher.feed.items != null
                ? ListFeedWidget(widget._fetcher.feed.items ?? [], filter)
                : const Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class ListFeedWidget extends StatelessWidget {
  final String filter;
  final List<RssItem> items;
  const ListFeedWidget(this.items, this.filter, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var showedItems = items
        .where((item) =>
            item.title!.toLowerCase().contains(filter) || filter.isEmpty)
        .toList();
    return ListView(
      shrinkWrap: true,
      children: showedItems.map((item) => FeedCard(item)).toList(),
    );
  }
}
