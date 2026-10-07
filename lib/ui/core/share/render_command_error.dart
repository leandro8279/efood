import 'package:efood/utils/app_exception.dart';
import 'package:efood/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RenderCommandError<T> extends StatelessWidget {
  const RenderCommandError({super.key, required this.command, required this.messageOf, required this.widget});

  final Rxn<Result<T>> command;
  final String Function(AppException error) messageOf;
  final Widget Function(String message) widget;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final message = switch (command.value) {
        Error(:final error) => messageOf(error),
        _ => null,
      };

      if (message == null || message.isEmpty) {
        return const SizedBox.shrink();
      }

      return widget(message);
    });
  }
}
