import 'package:flutter/material.dart';

class const RenderConditional({
  super.key,
  required final bool conditional,
  required final Widget widget1,
  required final Widget widget2,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return conditional ? widget1 : widget2;
  }
}
