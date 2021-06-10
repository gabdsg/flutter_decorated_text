import 'package:flutter/material.dart';
import 'package:flutter_decorated_text/flutter_decorated_text.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Decorated text example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Decorated text example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        brightness: Brightness.dark,
      ),
      body: ListView(
        padding: const EdgeInsets.all(40.0),
        children: [
          Text(
            "Match text beteen tags",
            style: Theme.of(context).textTheme.headline6,
          ),
          DecoratedText(
            selectable: true,
            overflow: TextOverflow.ellipsis,
            text:
                "Like between brackets {this is an example} or html tags <p>this is a paragraph</p>",
            rules: [
              DecoratorRule.between(
                start: "{",
                end: "}",
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
              DecoratorRule.between(
                start: "<p>",
                end: "</p>",
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
            ],
          ),
          Divider(),
          Text(
            "Match text starting with",
            style: Theme.of(context).textTheme.headline6,
          ),
          DecoratedText(
            text: "Like twitter accounts @gabdsg or hashtags #decoratedtext",
            rules: [
              DecoratorRule.startsWith(
                text: "@",
                onTap: (match) {
                  print(match);
                },
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
              DecoratorRule.startsWith(
                text: "#",
                onTap: (match) {
                  print(match);
                },
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
            ],
          ),
          Divider(),
          Text(
            "Match specific words",
            style: Theme.of(context).textTheme.headline6,
          ),
          DecoratedText(
            text:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
            rules: [
              DecoratorRule.words(
                words: ["lorem ipsum", "industry", "book", "make"],
                onTap: (match) {
                  print(match);
                },
                style: TextStyle(
                  background: Paint()..color = Colors.yellow,
                ),
              ),
            ],
          ),
          Divider(),
          Text(
            "Match links",
            style: Theme.of(context).textTheme.headline6,
          ),
          DecoratedText(
            text:
                "You can match links with https https://pub.dev/ and links without it like google.com",
            rules: [
              DecoratorRule.url(
                onTap: (url) {
                  print(url);
                },
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
                humanize: false,
                removeWww: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
