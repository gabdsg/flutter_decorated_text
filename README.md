# Decorated text

## Usage
```
final bracketsRegExp = RegExp(
    "{(.*?)}",
    multiLine: true,
    caseSensitive: false,
);

// Add to text fields
TextField(
    controller: DecoratedTextEditingController(
        text: _text,
        rules: [
            DecoratorRule(
                regExp: bracketsRegExp,
                style: TextStyle(
                    color: Colors.blue,
                ),
                onTap: (text) {
                    print("Tapped: $text");
                },
            ),
        ],
    ),
);

// Normal text
DecoratedText(
    text:
        "This is an {example} text",

    rules: [
        DecoratorRule(
            regExp: bracketsRegExp,
            style: TextStyle(
                color: Colors.blue,
            ),
            onTap: (text) {
                print("Tapped: $text");
            },
        ),
    ],
);
```
