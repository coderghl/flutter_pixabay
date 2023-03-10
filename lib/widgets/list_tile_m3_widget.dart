import 'package:flutter/material.dart';

class ListTileM3Widget extends StatelessWidget {
  const ListTileM3Widget({
    super.key,
    required this.title,
    this.subtitle,
    this.margin = const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
    this.leading,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.shape,
  });

  final EdgeInsetsGeometry margin;
  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final void Function()? onTap;
  final void Function()? onLongPress;
  final ShapeBorder? shape;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin,
      child: ListTile(
        onLongPress: onLongPress,
        onTap: onTap,
        shape: shape ??
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
        leading: leading,
        trailing: trailing,
        title: title,
        subtitle: subtitle,
      ),
    );
  }
}
