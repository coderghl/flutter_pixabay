import 'package:flutter/material.dart';

class KeepAliveWidget extends StatefulWidget {
  const KeepAliveWidget({
    super.key,
    required this.child,
    this.wantKeepAlive = true,
  });
  final bool wantKeepAlive;
  final Widget child;

  @override
  State<KeepAliveWidget> createState() => _KeepAliveWidgetState();
}

class _KeepAliveWidgetState extends State<KeepAliveWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => widget.wantKeepAlive;
}
