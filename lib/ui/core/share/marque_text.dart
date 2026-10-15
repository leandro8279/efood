import 'package:flutter/material.dart';

class const MarqueText({
  super.key,
  required final Widget child,
  final Axis direction = Axis.horizontal,
  final Duration animationDuration = const Duration(milliseconds: 30000),
  final Duration backDuration = const Duration(milliseconds: 30000),
  final Duration pauseDuration = const Duration(milliseconds: 500),
}) extends StatefulWidget {
  @override
  State<MarqueText> createState() => _MarqueTextState();
}

class _MarqueTextState extends State<MarqueText> {
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController(initialScrollOffset: 50.0);
    WidgetsBinding.instance.addPostFrameCallback(scroll);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(scrollDirection: widget.direction, controller: scrollController, child: widget.child);
  }

  void scroll(_) async {
    while (scrollController.hasClients) {
      await Future.delayed(widget.pauseDuration);
      if (scrollController.hasClients) {
        await scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: widget.animationDuration,
          curve: Curves.ease,
        );
      }
      await Future.delayed(widget.pauseDuration);
      if (scrollController.hasClients) {
        await scrollController.animateTo(0.0, duration: widget.backDuration, curve: Curves.easeOut);
      }
    }
  }
}
