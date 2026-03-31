import 'package:flutter/material.dart';

/// Renders chat message text with inline custom emoji images.
///
/// Custom emojis are embedded in the text as `\uFFFC<url>\uFFFC` markers.
/// This widget parses those markers and renders them as inline images.
///
/// Pass [imageSize] to override the default emoji size (e.g. for Super Stickers).
class ChatMessageText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool selectable;
  /// Override image size for all embedded images (e.g. Super Stickers).
  final double? imageSize;

  const ChatMessageText(
    this.text, {
    super.key,
    this.style,
    this.maxLines,
    this.overflow,
    this.selectable = false,
    this.imageSize,
  });

  @override
  Widget build(BuildContext context) {
    final spans = _parseSpans(
      text,
      style ?? DefaultTextStyle.of(context).style,
      imageSize: imageSize,
    );

    // No custom emojis — fast path
    if (spans.length == 1 && spans.first is TextSpan) {
      if (selectable) {
        return SelectableText(
          text,
          style: style,
          maxLines: maxLines,
        );
      }
      return Text(
        text,
        style: style,
        maxLines: maxLines,
        overflow: overflow,
      );
    }

    if (selectable) {
      return Text.rich(
        TextSpan(children: spans),
        style: style,
        maxLines: maxLines,
        overflow: overflow,
      );
    }
    return Text.rich(
      TextSpan(children: spans),
      style: style,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  static List<InlineSpan> _parseSpans(String text, TextStyle baseStyle,
      {double? imageSize}) {
    final spans = <InlineSpan>[];
    final emojiSize = imageSize ?? (baseStyle.fontSize ?? 14.0) * 1.4;
    int start = 0;

    while (start < text.length) {
      final markerStart = text.indexOf('\uFFFC', start);
      if (markerStart == -1) {
        // No more markers — add remaining text
        spans.add(TextSpan(text: text.substring(start)));
        break;
      }

      // Add text before the marker
      if (markerStart > start) {
        spans.add(TextSpan(text: text.substring(start, markerStart)));
      }

      // Find the closing marker
      final markerEnd = text.indexOf('\uFFFC', markerStart + 1);
      if (markerEnd == -1) {
        // No closing marker — add the rest as text
        spans.add(TextSpan(text: text.substring(markerStart)));
        break;
      }

      var url = text.substring(markerStart + 1, markerEnd);
      // Normalise protocol-relative URLs (safety net)
      if (url.startsWith('//')) {
        url = 'https:$url';
      }
      if (url.startsWith('http')) {
        spans.add(WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1),
            child: Image.network(
              url,
              width: emojiSize,
              height: emojiSize,
              errorBuilder: (_, __, ___) => SizedBox(
                width: emojiSize,
                height: emojiSize,
              ),
            ),
          ),
        ));
      } else {
        // Not a valid URL, keep as text
        spans.add(TextSpan(text: text.substring(markerStart, markerEnd + 1)));
      }

      start = markerEnd + 1;
    }

    if (spans.isEmpty) {
      spans.add(const TextSpan(text: ''));
    }
    return spans;
  }
}
