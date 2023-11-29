import 'package:flutter/Material.dart';
import 'package:lifestyle/components/user/home/widgets/categories_image_template.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RotatedBox(
          quarterTurns: 1,
          child: Align(
            child: SizedBox(
              height: 8.w,
              width: 50.h,
              //  padding: const EdgeInsets.only(bottom: 20),
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: Colors.white,
                // Color(0xFF98806B),
                unselectedLabelColor: const Color(0xFF675E57),
                dividerColor: const Color(0xFF675E57),
                indicatorWeight: 1,
                isScrollable: true,
                labelStyle: TextStyle(
                    fontFamily: 'Comorant-Regular', fontSize: 17.5.sp),
                controller: tabController,
                // indicator:
                //  CircleTabBarIndicator(
                //     color: Colors.white.withOpacity(0.6), radius: 9.sp),
                indicatorColor: Colors.white,
                tabs: const [
                  Tab(
                    text: 'Sofas',
                  ),
                  Tab(
                    text: 'Armchairs',
                  ),
                  Tab(
                    text: 'Tables',
                  ),
                  Tab(
                    text: 'Beds',
                  ),
                  Tab(
                    text: 'Accessories',
                  ),
                  Tab(
                    text: 'Lights',
                  ),
                ],
              ),
            ),
          ),
        ),
        //TabBar View Flexibled Containter
        Flexible(
          child: SizedBox(
            height: 50.h,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: TabBarView(
                controller: tabController,
                children: const [
                  CategoriesImageTemplate(
                    image: AssetImage('images/Sofa2.jpeg'),
                    index: 0,
                    color: Colors.transparent,
                  ),
                  CategoriesImageTemplate(
                    image: AssetImage('images/armchair.jpeg'),
                    index: 1,
                    color: Colors.transparent,
                  ),
                  CategoriesImageTemplate(
                    image: AssetImage('images/sofa.jpeg'),
                    index: 2,
                    color: Colors.transparent,
                  ),
                  CategoriesImageTemplate(
                    image: AssetImage('images/bedd.jpeg'),
                    index: 3,
                    color: Colors.transparent,
                  ),
                  CategoriesImageTemplate(
                    image: AssetImage('images/accessoriess.jpeg'),
                    index: 4,
                    color: Colors.transparent,
                  ),
                  CategoriesImageTemplate(
                    image: AssetImage('images/light.jpeg'),
                    index: 5,
                    color: Colors.transparent,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CircleTabBarIndicator extends Decoration {
  final Color color;
  final double radius;

  const CircleTabBarIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return CirclePainter(color: color, radius: radius);
  }
}

class CirclePainter extends BoxPainter {
  final Color color;
  double radius;

  CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint paint = Paint();
    paint.color = color;
    paint.isAntiAlias = true;
    Offset circleOffset = Offset(configuration.size!.width / 2 - radius / 2,
        configuration.size!.height - 11.w);
    canvas.drawCircle(offset + circleOffset, radius, paint);
  }
}
