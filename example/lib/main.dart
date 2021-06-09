import 'package:flutter/material.dart';
import 'package:flutter_decorated_text/decorated_text.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Decorated text example',
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            DecoratedText(
              text:
                  "Is This is an example text with a full url http://google.com and a loose url google.com and google. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
              rules: [
                DecoratorRule.word(
                  word: "google",
                  onTap: (match) {
                    print(match);
                  },
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                DecoratorRule.word(
                  word: "lorem ipsum",
                  onTap: (match) {
                    print(match);
                  },
                  style: TextStyle(
                    background: Paint()..color = Colors.yellow,
                  ),
                ),
                DecoratorRule.words(
                  words: ["leap", "but", "sheets", "with"],
                  onTap: (match) {
                    print(match);
                  },
                  style: TextStyle(
                    background: Paint()..color = Colors.lightBlue,
                  ),
                ),
                DecoratorRule.url(
                  onTap: (url) {
                    print(url);
                  },
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
