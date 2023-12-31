import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lifestyle/components/user/products/product-category/widgets/product_view_widget.dart';
import 'package:lifestyle/models-classes/category.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../products/product-category/widgets/parallax_image_card.dart';

class RoomDetailScreen extends StatelessWidget {
  const RoomDetailScreen({
    required this.category,
    super.key,
  });

  final ProductCategory category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: const ShAppBar(),
      body: RoomDetailItems(
        topPadding: 12,
        room: category,
      ),
    );
  }
}

class RoomDetailItems extends StatelessWidget {
  const RoomDetailItems({
    required this.room,
    required this.topPadding,
    this.animation = const AlwaysStoppedAnimation<double>(1),
    super.key,
  });

  final Animation<double> animation;
  final double topPadding;
  final ProductCategory room;

  @override
  Widget build(BuildContext context) {
    final outDx = 200 * animation.value;
    final outDy = 100 * animation.value;
    final sigma = 10 * animation.value;
    return Hero(
      tag: room.id,
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            ParallaxImageCard(imageUrl: room.imageUrl),
            ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaY: sigma, sigmaX: sigma),
                child: const ColoredBox(color: Colors.transparent),
              ),
            ),
            // --------------------------------------------
            // Animated output elements
            // --------------------------------------------
            FadeTransition(
              opacity: Tween<double>(begin: 1, end: 0).animate(animation),
              child: Stack(
                children: [
                  Transform.translate(
                    offset: Offset(-outDx, 0),
                    child: VerticalCategoryName(category: room),
                  ),
                  // Transform.translate(
                  //   offset: Offset(outDx, outDy),
                  //   child: const CameraIconButton(),
                  // ),
                  // Transform.translate(
                  //   offset: Offset(0, outDy),
                  //   child: const AnimatedUpwardArrows(),
                  // ),
                ],
              ),
            ),
            // --------------------------------------------
            // Animated room controls
            // --------------------------------------------
            FadeTransition(
              opacity: animation,
              child: Container(
                transform: Matrix4.translationValues(
                    0, -200 * (1 - animation.value), 0),
                padding: EdgeInsets.only(top: topPadding + 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      room.name.replaceAll(' ', '\n'),
                      textAlign: TextAlign.center,
                      // style: context.displaySmall.copyWith(height: .9),
                    ),
                    const Text('SETTINGS', textAlign: TextAlign.center),
                    Expanded(
                      child: RoomDetailsPageView(
                        animation: animation,
                        room: room,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RoomDetailsPageView extends StatelessWidget {
  const RoomDetailsPageView({
    required this.animation,
    required this.room,
    super.key,
  });

  final Animation<double> animation;
  final ProductCategory room;

  Animation<double> get _interval1 => CurvedAnimation(
        parent: animation,
        curve: const Interval(0.4, 1, curve: Curves.easeIn),
      );

  Animation<double> get _interval2 => CurvedAnimation(
        parent: animation,
        curve: const Interval(0.6, 1, curve: Curves.easeIn),
      );

  Animation<double> get _interval3 => CurvedAnimation(
        parent: animation,
        curve: const Interval(0.8, 1, curve: Curves.easeIn),
      );

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(color: Colors.white),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        children: [
          SlideTransition(
            position: Tween(
              begin: const Offset(0, 2),
              end: Offset.zero,
            ).animate(_interval1),
            child: FadeTransition(
              opacity: _interval1,
              child: Container(
                margin: EdgeInsets.only(top: 1.h),
                height: 20.h,
                width: 40.w,
                color: Colors.green,
              ),
            ),
          ),
          SlideTransition(
            position: Tween(
              begin: const Offset(0, 2),
              end: Offset.zero,
            ).animate(_interval2),
            child: FadeTransition(
              opacity: _interval2,
              child: Container(
                margin: EdgeInsets.only(top: 1.h),
                height: 20.h,
                width: 40.w,
                color: Colors.green,
              ),
            ),
          ),
          SlideTransition(
            position: Tween(
              begin: const Offset(0, 2),
              end: Offset.zero,
            ).animate(_interval3),
            child: FadeTransition(
              opacity: _interval3,
              child: Container(
                margin: EdgeInsets.only(top: 1.h),
                height: 20.h,
                width: 40.w,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
