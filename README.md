
# Flutter decorated text

Set different rules to the DecoratedText widget to style differently what each rule matches.

Add onTap callback to rules and get the matching text

## Screenshots

![Example screenshot](https://user-images.githubusercontent.com/748029/121581856-b7f68b00-ca04-11eb-88d9-33369e786433.png)


## Features

- Supports selectable text, just set selectable: true on the DecoratedText widget
- Premade rules for matching
    - Words
    - Text starting with some prefix
    - Text between tags
    - Links
- onTap callback returning matching text for individual rules
  
## Examples

### Match text beteen tags
```
DecoratedText(
    text: "Like between brackets {this is an example} or html tags <p>this is a paragraph</p>",
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
);
```

### Match text starting with
```
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
);
```

### Match specific words
```
DecoratedText(
    text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
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
);
```

### Match links
```
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
        ),
    ],
);
```

### Custom
```
DecoratedText(
    text: "Match links and add the favicon: https://pub.dev/, https://google.com, stackoverflow.com and talkingpts.org",
    rules: [
        DecoratorRule(
        regExp: RegExp(r'((https?:\/\/)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,4}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*))',
            caseSensitive: false,
            dotAll: true,
            multiLine: true,
        ),
        onTap: (url) {
            print(url);
        },
        style: TextStyle(
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
```