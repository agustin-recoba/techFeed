import 'package:flutter/material.dart';
import 'package:tech_feed/feed_fetchers/multi_feed_fetcher.dart';
import 'package:webfeed/domain/rss_item.dart';

import 'card/feed_card.dart';

class MultiFeedWidget extends StatefulWidget {
  final List<String> sources;
  late final animation = MultiFeedFetcher(sources);

  MultiFeedWidget(this.sources, {Key? key}) : super(key: key);

  @override
  State<MultiFeedWidget> createState() => _MultiFeedWidgetState();
}

class _MultiFeedWidgetState extends State<MultiFeedWidget> {
  bool userIsWriting = false;
  String filter = " ";
  List<RssItem> itemsBeingShown = [];

  @override
  Widget build(BuildContext context) {
    itemsBeingShown = widget.animation.items.where((item) {
      if (filter.isEmpty) {
        return true;
      }
      return item.title!.toLowerCase().contains(filter.toLowerCase());
    }).toList();
    Future.microtask(() {
      setState(() {});
    });
    return AnimatedBuilder(
      animation: widget.animation,
      builder: (_, __) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('Tech Feed'),
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
                                itemsBeingShown = itemsBeingShown
                                    .where((element) =>
                                        element.title!
                                            .toLowerCase()
                                            .contains(filter.toLowerCase()) ||
                                        filter.isEmpty)
                                    .toList();
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
                    setState(() {
                      widget.animation.updateAll();
                    });
                  },
                ),
              ],
            ),
            body: ListView(
              shrinkWrap: true,
              children: [
                for (var item in itemsBeingShown) FeedCard(item),
              ],
            ));
      },
    );
  }
}
