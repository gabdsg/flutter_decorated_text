# Decorated text

## Usage
```
DecoratedText(
    text:
        "Is This is an example text with a full url http://google.com and a loose url google.com and google. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    rules: [
        DecoratorRule.word(
            word: "lorem",
            onTap: (match) {
                print(match);
            },
            style: TextStyle(
                background: Paint()..color = Colors.yellow,
            ),
        ),
        DecoratorRule(
            regExp: RegExp(r"^(.*)"),
            onTap: (match) {
                print(match);
            },
            style: TextStyle(
                color: Colors.red,
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
);
```
