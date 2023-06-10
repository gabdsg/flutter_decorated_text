# Flutter DecoratedText

The `DecoratedText` widget allows you to style and interact with different parts of a text string based on predefined rules. It's versatile, easy-to-use, and can handle different scenarios such as matching specific words, phrases, or patterns, allowing you to style the matched text differently.

![Example screenshot](https://user-images.githubusercontent.com/748029/121581856-b7f68b00-ca04-11eb-88d9-33369e786433.png)

## Features

- **Selectable Text:** Enable the selectable property (`selectable: true`) to allow text selection in the `DecoratedText` widget.
- **Predefined Rules:** These are used to match different elements within the text. These rules include:
    - Matching words.
    - Matching text starting with a particular prefix.
    - Matching text between specific tags.
    - Matching links (URLs).
- **Interactive:** Each rule can include an `onTap` callback, which returns the matched text, allowing you to implement interactive behavior such as opening a link when a URL is tapped.

## Usage Examples

### Match Text Between Tags

```dart
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

### Match Text Starting With a Prefix

```dart
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

### Match Specific Words

```dart
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

### Match URLs

```dart
DecoratedText(
    text: "You can match links with https https://pub.dev/ and links without it like google.com",
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

### Custom Rule using Regular Expressions

```dart
DecoratedText(
    text: "Match links and add the favicon: https://pub.dev/, https://google.com, stackoverflow.com and talkingpts.org",
    rules: [
        DecoratorRule(
        regExp: RegExp(r'((https?:\/\/)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256

}\.[a-z]{2,4}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*))',
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


### Match emojis
```
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
```

Remember, with the `DecoratedText` widget, you can style your text based on predefined rules, add interactivity, and handle complex matching scenarios with ease. Happy coding!