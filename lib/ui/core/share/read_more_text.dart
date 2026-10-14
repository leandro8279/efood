import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

enum TrimMode { length, line }

class ReadMoreText extends StatefulWidget {
  const ReadMoreText(
    this.data, {
    super.key,
    this.preDataText,
    this.postDataText,
    this.preDataTextStyle,
    this.postDataTextStyle,
    this.trimExpandedText = 'show less',
    this.trimCollapsedText = 'read more',
    this.colorClickableText,
    this.trimLength = 240,
    this.trimLines = 2,
    this.trimMode = TrimMode.length,
    this.style,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.textScaleFactor,
    this.semanticsLabel,
    this.moreStyle,
    this.lessStyle,
    this.delimiter = '… ',
    this.delimiterStyle,
    this.callback,
  });

  final int trimLength;
  final int trimLines;
  final TrimMode trimMode;

  final TextStyle? moreStyle;
  final TextStyle? lessStyle;

  final String? preDataText;
  final String? postDataText;

  final TextStyle? preDataTextStyle;
  final TextStyle? postDataTextStyle;

  final ValueChanged<bool>? callback;

  final String delimiter;
  final String data;
  final String trimExpandedText;
  final String trimCollapsedText;

  final Color? colorClickableText;
  final TextStyle? style;

  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;

  // Mantido para compatibilidade com a API original.
  // Está obsoleto nas versões recentes do Flutter.
  final double? textScaleFactor;

  final String? semanticsLabel;
  final TextStyle? delimiterStyle;

  @override
  State<ReadMoreText> createState() => ReadMoreTextState();
}

const String kEllipsis = '\u2026';

const String kLineSeparator = '\u2028';

class ReadMoreTextState extends State<ReadMoreText> {
  bool readMore = true;

  void onTapLink() {
    setState(() {
      readMore = !readMore;
      widget.callback?.call(readMore);
    });
  }

  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    TextStyle? effectiveTextStyle = widget.style;
    if (widget.style?.inherit ?? false) {
      effectiveTextStyle = defaultTextStyle.style.merge(widget.style);
    }

    final textAlign = widget.textAlign ?? defaultTextStyle.textAlign ?? TextAlign.start;
    final textDirection = widget.textDirection ?? Directionality.of(context);
    final textScaleFactor = widget.textScaleFactor ?? MediaQuery.textScaleFactorOf(context);
    final overflow = defaultTextStyle.overflow;
    final locale = widget.locale ?? Localizations.maybeLocaleOf(context);

    final colorClickableText = widget.colorClickableText ?? Theme.of(context).colorScheme.secondary;
    final defaultLessStyle = widget.lessStyle ?? effectiveTextStyle?.copyWith(color: colorClickableText);
    final defaultMoreStyle = widget.moreStyle ?? effectiveTextStyle?.copyWith(color: colorClickableText);
    final defaultDelimiterStyle = widget.delimiterStyle ?? effectiveTextStyle;

    TextSpan link = TextSpan(
      text: readMore ? widget.trimCollapsedText : widget.trimExpandedText,
      style: readMore ? defaultMoreStyle : defaultLessStyle,
      recognizer: TapGestureRecognizer()..onTap = onTapLink,
    );

    TextSpan delimiter = TextSpan(
      text: readMore
          ? widget.trimCollapsedText.isNotEmpty
                ? widget.delimiter
                : ''
          : '',
      style: defaultDelimiterStyle,
      recognizer: TapGestureRecognizer()..onTap = onTapLink,
    );

    Widget result = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        final double maxWidth = constraints.maxWidth;

        TextSpan? preTextSpan;
        TextSpan? postTextSpan;
        if (widget.preDataText != null)
          preTextSpan = TextSpan(
            text: "${widget.preDataText} ",
            style: widget.preDataTextStyle != null ? widget.preDataTextStyle : effectiveTextStyle,
          );
        if (widget.postDataText != null)
          postTextSpan = TextSpan(
            text: " " + widget.postDataText!,
            style: widget.postDataTextStyle ?? effectiveTextStyle,
          );

        // Create a TextSpan with data
        final text = TextSpan(
          children: [
            if (preTextSpan != null) preTextSpan,
            TextSpan(text: widget.data, style: effectiveTextStyle),
            if (postTextSpan != null) postTextSpan,
          ],
        );

        // Layout and measure link
        TextPainter textPainter = TextPainter(
          text: link,
          textAlign: textAlign,
          textDirection: textDirection,
          textScaleFactor: textScaleFactor,
          maxLines: widget.trimLines,
          ellipsis: overflow == TextOverflow.ellipsis ? widget.delimiter : null,
          locale: locale,
        );
        textPainter.layout(minWidth: 0, maxWidth: maxWidth);
        final linkSize = textPainter.size;

        // Layout and measure delimiter
        textPainter.text = delimiter;
        textPainter.layout(minWidth: 0, maxWidth: maxWidth);
        final delimiterSize = textPainter.size;

        // Layout and measure text
        textPainter.text = text;
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final textSize = textPainter.size;

        // Get the endIndex of data
        bool linkLongerThanLine = false;
        int endIndex;

        if (linkSize.width < maxWidth) {
          final readMoreSize = linkSize.width + delimiterSize.width;
          final pos = textPainter.getPositionForOffset(
            Offset(textDirection == TextDirection.rtl ? readMoreSize : textSize.width - readMoreSize, textSize.height),
          );
          endIndex = textPainter.getOffsetBefore(pos.offset) ?? 0;
        } else {
          var pos = textPainter.getPositionForOffset(textSize.bottomLeft(Offset.zero));
          endIndex = pos.offset;
          linkLongerThanLine = true;
        }

        var textSpan;
        switch (widget.trimMode) {
          case TrimMode.length:
            if (widget.trimLength < widget.data.length) {
              textSpan = TextSpan(
                style: effectiveTextStyle,
                text: readMore ? widget.data.substring(0, widget.trimLength) : widget.data,
                children: <TextSpan>[delimiter, link],
              );
            } else {
              textSpan = TextSpan(style: effectiveTextStyle, text: widget.data);
            }
            break;
          case TrimMode.line:
            if (textPainter.didExceedMaxLines) {
              textSpan = TextSpan(
                style: effectiveTextStyle,
                text: readMore
                    ? widget.data.substring(0, endIndex) + (linkLongerThanLine ? kLineSeparator : '')
                    : widget.data,
                children: <TextSpan>[delimiter, link],
              );
            } else {
              textSpan = TextSpan(style: effectiveTextStyle, text: widget.data);
            }
            break;
        }

        return AnimatedSize(
          duration: Duration(milliseconds: 500),
          curve: Curves.fastLinearToSlowEaseIn,
          alignment: Alignment.topLeft,
          child: Text.rich(
            TextSpan(
              children: [if (preTextSpan != null) preTextSpan, textSpan, if (postTextSpan != null) postTextSpan],
            ),
            textAlign: textAlign,
            textDirection: textDirection,
            softWrap: true,
            overflow: TextOverflow.clip,
            textScaleFactor: textScaleFactor,
          ),
        );
      },
    );
    if (widget.semanticsLabel != null) {
      result = Semantics(
        textDirection: widget.textDirection,
        label: widget.semanticsLabel,
        child: ExcludeSemantics(child: result),
      );
    }
    return result;
  }
}
