import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';

var parser = EmojiParser();

class EmojiWithText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final TextStyle style;
  EmojiWithText(
      {required this.text, required this.textAlign, required this.style});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign,
      text: TextSpan(
        children: _buildTextSpans(),
        style: style,
      ),
    );
  }

  List<TextSpan> _buildTextSpans() {
    final List<TextSpan> textSpans = [];

    final emojiRegex = RegExp(r':([a-z_]+):'); // Regex để tìm emoji trong chuỗi

    final matches =
        emojiRegex.allMatches(text); // Tìm tất cả các emoji trong chuỗi

    int previousIndex = 0;

    // Lặp qua các emoji và tạo các TextSpan cho mỗi emoji và văn bản xung quanh nó
    for (final match in matches) {
      if (match.start > previousIndex) {
        final nonEmojiText = text.substring(previousIndex, match.start);
        textSpans.add(TextSpan(text: nonEmojiText));
      }

      final emojiName = match.group(1);
      final emojiUnicode =
          _getEmojiUnicode(emojiName!); // Lấy Unicode của emoji

      textSpans.add(
        TextSpan(
          text: emojiUnicode,
          style: TextStyle(fontSize: 20), // Tuỳ chỉnh font size cho emoji
        ),
      );

      previousIndex = match.end;
    }

    // Thêm phần còn lại của chuỗi (sau khi đã xử lý các emoji)
    if (previousIndex < text.length) {
      final remainingText = text.substring(previousIndex);
      textSpans.add(TextSpan(text: remainingText));
    }

    return textSpans;
  }

  String _getEmojiUnicode(String emojiName) {
    return parser.get(emojiName).code;
  }
}
