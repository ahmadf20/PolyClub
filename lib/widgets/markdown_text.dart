import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

/// A widget that replace Text Widget as it gives more flexibility of showing a simple markdown text in a [Text], i.e. make the word bold, italic, etc in a [Text] instead of using [RichText]
class MyText extends StatelessWidget {
  const MyText(this.text, {Key? key, this.style}) : super(key: key);

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: text,
      styleSheet: MarkdownStyleSheet(
        p: style,
        strong: style?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}
