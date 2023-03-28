import 'package:flutter/material.dart';

class SkeletonContainer extends StatefulWidget {
  const SkeletonContainer({super.key, required this.size});
  final Size size;

  @override
  State<SkeletonContainer> createState() => _SkeletonContainerState();
}

class _SkeletonContainerState extends State<SkeletonContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    animation = Tween(begin: -1.0, end: 2.0).animate(_controller);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        _controller.repeat(reverse: true);
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return Container(
          width: widget.size.width,
          height: widget.size.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).colorScheme.secondary.withOpacity(.4),
                Theme.of(context).colorScheme.secondary.withOpacity(.6),
                Theme.of(context).colorScheme.secondary.withOpacity(.8),
              ],
              stops: [
                animation.value - 1,
                animation.value,
                animation.value + 1,
              ],
            ),
          ),
        );
      },
    );
    ;
  }
}
