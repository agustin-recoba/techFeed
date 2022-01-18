import 'package:flutter/material.dart';

import 'feed_widgets/every_source_feed.dart';
import 'feed_widgets/single_source_feed.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tech News',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ).copyWith(cardColor: Colors.redAccent),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, String> sources = {
    "Wired": "https://www.wired.com/feed/",
    "Techcrunch": "https://techcrunch.com/feed/",
    "The-Next-Web": "https://thenextweb.com/feed/",
    "Engadget": "https://www.engadget.com/rss.xml",
    "Mashable": "https://mashable.com/feed/",
    "The-Guardian-US": "https://www.theguardian.com/us/rss",
    "NASA": "https://www.nasa.gov/rss/dyn/breaking_news.rss",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          String url = "";
          String title = "";
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    title: const Text('Add a new RSS source'),
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          decoration: const InputDecoration(
                            labelText: 'Source name',
                          ),
                          onChanged: (value) {
                            title = value;
                          },
                        ),
                        TextField(
                          decoration: const InputDecoration(
                            labelText: 'Source URL',
                          ),
                          onChanged: (value) {
                            url = value;
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                sources[title] = url;
                                Navigator.pop(context);
                              });
                            },
                            child: const Text('Add'))
                      ],
                    ),
                  ));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Tech News'),
        actions: [
          ElevatedButton(
            child: const Text('All'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MultiFeedWidget(sources.values.toList()),
                ),
              );
            },
          ),
        ],
      ),
      body: ReorderableListView(
          onReorder: (int oldIndex, int newIndex) {
            setState(() {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              var entries = sources.entries.toList();
              var entry = entries.removeAt(oldIndex);
              entries.insert(newIndex, entry);
              sources = Map.fromEntries(entries);
            });
          },
          children: [
            for (var key in sources.keys) ...[
              ListTile(
                key: ValueKey(key),
                title: Text(key),
                subtitle: Text(sources[key] as String),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      sources.remove(key);
                    });
                  },
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          FeedWidget(key, sources[key] as String),
                    ),
                  );
                },
              ),
            ],
          ]),
    );
  }
}
