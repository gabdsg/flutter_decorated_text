import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_decorated_text/flutter_decorated_text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Decorated text example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ExampleScreen(),
    );
  }
}

class ExampleScreen extends StatefulWidget {
  const ExampleScreen({super.key});

  @override
  State<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  @override
  void initState() {
    super.initState();
  }

  String sanitizeUrl(String url) {
    if (!url.startsWith("http://") && !url.startsWith("https://")) {
      url = "https://$url";
    }
    if (url.endsWith(".")) {
      url = url.substring(0, url.length - 1);
    }
    if (url.endsWith("/")) {
      url = url.substring(0, url.length - 1);
    }
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Decorated text example"),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: ListView(
        padding: const EdgeInsets.all(40.0),
        children: [
          Text(
            "Match text beteen tags",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          DecoratedText(
            selectable: true,
            text:
                "Like between brackets {this is an example} or html tags <p>this is a paragraph</p> and you can remove the matching characters *between astericks*",
            rules: [
              DecoratorRule.between(
                start: "{",
                end: "}",
                style: const TextStyle(
                  color: Colors.blue,
                ),
              ),
              DecoratorRule.between(
                start: "<p>",
                end: "</p>",
                style: const TextStyle(
                  color: Colors.green,
                ),
              ),
              DecoratorRule.between(
                start: "*",
                end: "*",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                removeMatchingCharacters: true,
              ),
            ],
          ),
          const Divider(),
          Text(
            "Match text starting with",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          DecoratedText(
            text: "Like twitter accounts @gabdsg or hashtags #decoratedtext",
            rules: [
              DecoratorRule.startsWith(
                text: "@",
                onTap: (match) {
                  debugPrint(match);
                },
                style: const TextStyle(
                  color: Colors.blue,
                ),
              ),
              DecoratorRule.startsWith(
                text: "#",
                onTap: (match) {
                  debugPrint(match);
                },
                style: const TextStyle(
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const Divider(),
          Text(
            "Match specific words",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          DecoratedText(
            text:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
            rules: [
              DecoratorRule.words(
                words: ["lorem ipsum", "industry", "book", "make"],
                onTap: (match) {
                  debugPrint(match);
                },
                style: TextStyle(
                  background: Paint()..color = Colors.yellow,
                ),
              ),
            ],
          ),
          const Divider(),
          Text(
            "Match links",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          DecoratedText(
            text:
                "You can match links with https https://pub.dev/ and links without it like google.com",
            rules: [
              DecoratorRule.url(
                onTap: (url) {
                  debugPrint(url);
                },
                builder: (child, match) {
                  debugPrint(match);
                  return Container(
                    child: child,
                  );
                },
                style: const TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
                humanize: false,
                removeWww: false,
              ),
            ],
          ),
          const Divider(),
          Text(
            "Custom link match",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          DecoratedText(
            text:
                "Match links and add the favicon: https://pub.dev/, https://google.com, stackoverflow.com and talkingpts.org",
            rules: [
              DecoratorRule(
                regExp: RegExp(
                  r'((https?:\/\/)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,4}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*))',
                  caseSensitive: false,
                  dotAll: true,
                  multiLine: true,
                ),
                onTap: (url) {
                  debugPrint(url);
                },
                style: const TextStyle(
                  color: Colors.blue,
                ),
                leadingBuilder: (match) => Container(
                  width: 16 * 0.8,
                  height: 16 * 0.8,
                  margin: const EdgeInsets.only(right: 2, left: 2),
                  child: CachedNetworkImage(
                    imageUrl: "${sanitizeUrl(match)}/favicon.ico",
                  ),
                ),
              ),
            ],
          ),
          const Divider(),
          Text(
            "Match emojis on text",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          DecoratedText(
            text: "I love Flutter! 😍",
            rules: [
              DecoratorRule(
                regExp: RegExp(r'(\p{Emoji_Presentation})', unicode: true),
                style: const TextStyle(
                  fontSize: 30.0,
                ),
                onTap: (emoji) {
                  debugPrint('You tapped on the emoji: $emoji');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
