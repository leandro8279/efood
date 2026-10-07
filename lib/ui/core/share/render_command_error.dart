import 'package:efood/ui/core/share/error_messages.dart';
import 'package:efood/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RenderCommandError<T> extends StatelessWidget {
  const RenderCommandError({super.key, required this.command, required this.widget});

  final Rxn<Result<T>> command;
  final Widget Function(String message) widget;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final message = switch (command.value) {
        Error(:final error) => ErrorMessages.of(error),
        _ => null,
      };

      if (message == null || message.isEmpty) {
        return const SizedBox.shrink();
      }

      return widget(message.tr);
    });
  }
}
