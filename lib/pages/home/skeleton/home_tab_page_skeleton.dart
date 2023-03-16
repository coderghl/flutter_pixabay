import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeTabPageSkeleton extends StatefulWidget {
  const HomeTabPageSkeleton({Key? key}) : super(key: key);

  @override
  State<HomeTabPageSkeleton> createState() => _HomeTabPageSkeletonState();
}

class _HomeTabPageSkeletonState extends State<HomeTabPageSkeleton> with SingleTickerProviderStateMixin {
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
      if (status == AnimationStatus.completed || status == AnimationStatus.dismissed) {
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
    return MasonryGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 8,
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        var height = Random().nextDouble() * 150 + 50;
        return AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget? child) {
            return Container(
              height: height,
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
      },
    );
  }
}
