// // import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
// // import 'package:flutter/material.dart';
// // import 'package:vector_math/vector_math_64.dart' as vector;

// // class HelloWorld extends StatefulWidget {
// //   @override
// //   _HelloWorldState createState() => _HelloWorldState();
// // }

// // class _HelloWorldState extends State<HelloWorld> {
// //   ArCoreController? arCoreController;

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: Scaffold(
// //         appBar: AppBar(
// //           title: const Text('Hello World'),
// //         ),
// //         body: ArCoreView(
// //           onArCoreViewCreated: _onArCoreViewCreated,
// //         ),
// //       ),
// //     );
// //   }

// //   void _onArCoreViewCreated(ArCoreController controller) {
// //     arCoreController = controller;

// //     _addModel(arCoreController!);
// //   }

// //   void _addModel(ArCoreController controller) {
// //     final node = ArCoreReferenceNode(name: 'Test Node', objectUrl: '');
// //     controller.addArCoreNode(node);
// //   }

// //   @override
// //   void dispose() {
// //     arCoreController!.dispose();
// //     super.dispose();
// //   }
// // }

// import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
// import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
// import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
// import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
// import 'package:ar_flutter_plugin/models/ar_anchor.dart';
// import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
// import 'package:flutter/material.dart';
// import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
// import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
// import 'package:ar_flutter_plugin/datatypes/node_types.dart';
// import 'package:ar_flutter_plugin/datatypes/hittest_result_types.dart';
// import 'package:ar_flutter_plugin/models/ar_node.dart';
// import 'package:ar_flutter_plugin/models/ar_hittest_result.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:get/get.dart' as x;
// import 'package:get/get.dart';
// import 'package:lifestyle/Common/cache_image.dart';
// import 'package:lifestyle/Common/global_variables.dart';
// import 'package:lifestyle/features/Home/services/home_services.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:vector_math/vector_math_64.dart' as vector;
// import 'dart:math';
// import 'dart:developer' as dev;
// import '../../../Common/app_constants.dart';
// import '../../../Common/medium_text.dart';
// import '../../../RoutesManagement/gex_routes_name.dart';
// import '../../../models/product.dart';
// import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

// class ArView extends StatefulWidget {
//   const ArView({Key? key}) : super(key: key);
//   @override
//   ArViewState createState() => ArViewState();
// }

// class ArViewState extends State<ArView> {
//   ArCoreController? arCoreController;
//   // late ARNode newNode;
//   ARNode? webObjectNode;
//   ArFlutterPlugin? arPluginController;
//   ARSessionManager? arSessionManager;
//   ARObjectManager? arObjectManager;
//   ARAnchorManager? arAnchorManager;

//   // List<ARNode> nodes = [];
//   // List<ARAnchor> anchors = [];

//   Product product = x.Get.arguments;
//   GlobalKey pickItemKey = GlobalKey();
//   GlobalKey placeItemKey = GlobalKey();
//   GlobalKey clearAllKey = GlobalKey();
//   GlobalKey rotateKey = GlobalKey();

//   List<TargetFocus> tagetList = [];
//   bool isMenuVisible = false;
//   final PageController _pageController = PageController();
//   List<Product> sofas = [];
//   List<Product> armchairs = [];
//   List<Product> tables = [];
//   List<Product> beds = [];
//   List<Product> accessories = [];
//   List<Product> lights = [];
//   List<String> categoryImages = [
//     'images/sofa.jpeg',
//     'images/armchair.jpeg',
//     'images/Sofa3.jpeg',
//     'images/bedd.jpeg',
//     'images/accessories.jpeg',
//     'images/light.jpeg',
//   ];
//   var _selectedModelUrl = '';
//   @override
//   void initState() {
//     super.initState();
//     fetchSofa();
//     fetchAccessories();
//     fetchArmChairs();
//     fetchBeds();
//     fetchTables();
//     fetchLight();
//     tagetList.add(
//       TargetFocus(
//         identify: 'Select an Item',
//         keyTarget: pickItemKey,
//         contents: [
//           TargetContent(
//             align: ContentAlign.top,
//             child: const MediumText(
//                 overflow: TextOverflow.visible,
//                 // font: 'Cera',
//                 text: 'Click here to select an item to add to the scene'),
//           )
//         ],
//       ),
//     );

//     tagetList.add(TargetFocus(
//         identify: 'Place Selected Item',
//         keyTarget: placeItemKey,
//         contents: [
//           TargetContent(
//               align: ContentAlign.top,
//               child: Column(
//                 children: const [
//                   MediumText(
//                       overflow: TextOverflow.visible,
//                       // font: 'Cera',
//                       text:
//                           'Tap on any surface in the scene to place the selected item')
//                 ],
//               ))
//         ]));
//     tagetList.add(
//       TargetFocus(
//         identify: 'Rotate Item',
//         keyTarget: rotateKey,
//         contents: [
//           TargetContent(
//               align: ContentAlign.bottom,
//               child: Column(
//                 children: const [
//                   MediumText(
//                     overflow: TextOverflow.visible,
//                     // font: 'Cera',
//                     text:
//                         'To easily rotate an item, tap on it to select it and then rotate any path of the screen with two fingers',
//                   )
//                 ],
//               ))
//         ],
//       ),
//     );

//     tagetList.add(
//       TargetFocus(
//         identify: 'Select Item',
//         keyTarget: clearAllKey,
//         contents: [
//           TargetContent(
//             align: ContentAlign.bottom,
//             child: Column(
//               children: const [
//                 MediumText(
//                     overflow: TextOverflow.visible,
//                     // font: 'Cera',
//                     text: 'Click here to remove all items from the scene')
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   startTutorial(BuildContext context) {
//     TutorialCoachMark tutorial = TutorialCoachMark(
//       targets: tagetList,
//       colorShadow: const Color(0xFF675E57).withOpacity(0.3),
//       onFinish: () {
//         dev.log("Tutorial finished");
//       },
//       onClickTarget: (target) {
//         dev.log("Clicked on target: $target");
//       },
//       onSkip: () {
//         dev.log("Tutorial skipped");
//       },
//     )..show(context: context);
//   }

//   final HomeServices homeServices = HomeServices();
//   fetchSofa() async {
//     sofas = await homeServices.fetchProductCategory(
//         context: context, category: GlobalVariables.categoryTitles[0]);
//   }

//   fetchArmChairs() async {
//     armchairs = await homeServices.fetchProductCategory(
//         context: context, category: GlobalVariables.categoryTitles[1]);
//   }

//   fetchTables() async {
//     tables = await homeServices.fetchProductCategory(
//         context: context, category: GlobalVariables.categoryTitles[2]);
//   }

//   fetchBeds() async {
//     beds = await homeServices.fetchProductCategory(
//         context: context, category: GlobalVariables.categoryTitles[3]);
//   }

//   fetchAccessories() async {
//     accessories = await homeServices.fetchProductCategory(
//         context: context, category: GlobalVariables.categoryTitles[4]);
//   }

//   fetchLight() async {
//     lights = await homeServices.fetchProductCategory(
//         context: context, category: GlobalVariables.categoryTitles[5]);
//   }

//   // Vector3 _scaleFactor = Vector3(0.5, 0.5, 0.5);
//   // final double angle = 0.0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton: FloatingActionButton(
//         key: pickItemKey,
//         backgroundColor: const Color(0xFF675E57),
//         onPressed: () {
//           setState(() {
//             isMenuVisible = !isMenuVisible;
//           });
//         },
//         child: const Icon(
//           Icons.add,
//           color: Colors.white,
//         ),
//       ),
//       appBar: AppBar(
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: Colors.black,
//         title: MediumText(
//           text: 'AR VIEW',
//           font: comorant,
//         ),
//       ),
//       body: Stack(
//         children: [
//           ArCoreView(
//             onArCoreViewCreated: _onArCoreViewCreated,
//             enableTapRecognizer: true,
//             debug: true,
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: AnimatedContainer(
//               color: Color.fromARGB(0, 59, 37, 37),
//               duration: const Duration(milliseconds: 500),
//               height:
//                   isMenuVisible ? MediaQuery.of(context).size.height / 1.5 : 0,
//               child: buildGrid(),
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomLeft,
//             child: TextButton(
//               onPressed: () {
//                 _pageController.jumpToPage(0);
//                 // _pageController.animateToPage(0,
//                 //     duration: const Duration(milliseconds: 500),
//                 //     curve: Curves.easeIn);
//               },
//               child: isMenuVisible == false
//                   ? const SizedBox()
//                   : Container(
//                       alignment: Alignment.center,
//                       width: 23.w,
//                       height: 4.h,
//                       decoration: const BoxDecoration(color: Colors.black),
//                       child: MediumText(
//                         font: comorant,
//                         size: 15.sp,
//                         text: 'Categories'.toUpperCase(),
//                         color: Colors.white,
//                       ),
//                     ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.topRight,
//             child: GestureDetector(
//               onTap: () {},
//               child: Container(
//                 key: clearAllKey,
//                 margin: EdgeInsets.only(top: 1.h, right: 2.w),
//                 alignment: Alignment.center,
//                 width: 23.w,
//                 height: 3.5.h,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.white),
//                   // color: Color(0xFF675E57),
//                   color: Colors.transparent,
//                 ),
//                 child: MediumText(
//                   size: 14,
//                   text: 'CLEAR ALL',
//                   font: comorant,
//                 ),
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.center,
//             child: SizedBox(
//               key: placeItemKey,
//               height: 20.h,
//               width: 20.h,
//             ),
//           ),
//           Align(
//             alignment: Alignment.topLeft,
//             child: GestureDetector(
//               onTap: () {
//                 startTutorial(context);
//               },
//               child: Container(
//                 margin: EdgeInsets.only(top: 1.h, left: 2.w),
//                 alignment: Alignment.center,
//                 width: 23.w,
//                 height: 3.5.h,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.white),
//                   // color: Color(0xFF675E57),
//                   color: Colors.transparent,
//                 ),
//                 child: MediumText(
//                   size: 14,
//                   text: 'TUTORIAL',
//                   font: comorant,
//                 ),
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.center,
//             child: SizedBox(
//               key: rotateKey,
//               height: 18.h,
//               width: 18.h,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _onArCoreViewCreated(ArCoreController controller) {
//     arCoreController = controller;
//     _addModel(arCoreController!, model: product.models[0]);
//   }

//   void _addModel(ArCoreController controller, {required String model}) {
//     final node = ArCoreReferenceNode(
//       name: '3DModel',
//       object3DFileName: model,
//       position: vector.Vector3(0, 0, -1),
//       scale: vector.Vector3(0.5, 0.5, 0.5),
//     );
//     controller.addArCoreNode(node);
//   }

//   @override
//   void dispose() {
//     arCoreController!.dispose();
//     super.dispose();
//   }

//   Widget buildGrid() {
//     return PageView(controller: _pageController, children: [
//       Container(
//         decoration: const BoxDecoration(color: Color(0xFFB0A291)),
//         child: MasonryGridView.count(
//           itemCount: GlobalVariables.categoryTitles.length,
//           crossAxisCount: 1,
//           mainAxisSpacing: 3,
//           cacheExtent: 100,
//           crossAxisSpacing: 5,
//           itemBuilder: (context, index) {
//             return GestureDetector(
//               onTap: () {
//                 index == 0
//                     ? _pageController.animateToPage(1,
//                         duration: const Duration(milliseconds: 500),
//                         curve: Curves.easeIn)
//                     : index == 1
//                         ? _pageController.animateToPage(2,
//                             duration: const Duration(milliseconds: 500),
//                             curve: Curves.easeIn)
//                         : index == 2
//                             ? _pageController.animateToPage(3,
//                                 duration: const Duration(milliseconds: 500),
//                                 curve: Curves.easeIn)
//                             : index == 3
//                                 ? _pageController.animateToPage(4,
//                                     duration: const Duration(milliseconds: 500),
//                                     curve: Curves.easeIn)
//                                 : index == 4
//                                     ? _pageController.animateToPage(5,
//                                         duration:
//                                             const Duration(milliseconds: 500),
//                                         curve: Curves.easeIn)
//                                     : index == 5
//                                         ? _pageController.animateToPage(6,
//                                             duration: const Duration(
//                                                 milliseconds: 500),
//                                             curve: Curves.easeIn)
//                                         : _pageController.animateToPage(0,
//                                             duration: const Duration(
//                                                 milliseconds: 500),
//                                             curve: Curves.easeIn);
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     fit: BoxFit.cover,
//                     image: AssetImage(
//                       categoryImages[index],
//                     ),
//                   ),
//                   color: Colors.brown,
//                 ),
//                 alignment: Alignment.center,
//                 height: 20.h,
//                 width: 10.h,
//                 margin: EdgeInsets.only(left: 0.5.w, right: 0.5),
//                 child: MediumText(
//                     font: comorant,
//                     text: GlobalVariables.categoryTitles[index]
//                         .toString()
//                         .toUpperCase()),
//               ),
//             );
//           },
//         ),
//       ),
//       Container(
//         decoration: const BoxDecoration(color: Color(0xFFB0A291)),
//         margin: EdgeInsets.only(left: 1.w, right: 1.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             MediumText(
//               text: 'SOFA',
//               font: comorant,
//               size: 19.sp,
//             ),
//             Expanded(
//               child: MasonryGridView.count(
//                 itemCount: sofas.length,
//                 crossAxisCount: 2,
//                 mainAxisSpacing: 3,
//                 cacheExtent: 100,
//                 crossAxisSpacing: 3,
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                       onTap: () {
//                         _addModel(arCoreController!,
//                             model: sofas[index].models[0]);
//                         setState(() {
//                           _selectedModelUrl = sofas[index].models[0];
//                           isMenuVisible = false;
//                           x.Get.snackbar('SELECTED ITEM', sofas[index].name);
//                         });
//                       },
//                       child: Container(
//                         child: cacheImage(sofas[index].images[0]),
//                       ));
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       Container(
//         decoration: const BoxDecoration(color: Color(0xFFB0A291)),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             MediumText(
//               text: 'ARMCHAIRS',
//               font: comorant,
//               size: 19.sp,
//             ),
//             Expanded(
//               child: MasonryGridView.count(
//                 itemCount: armchairs.length,
//                 crossAxisCount: 2,
//                 mainAxisSpacing: 3,
//                 cacheExtent: 100,
//                 crossAxisSpacing: 3,
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     onTap: () {
//                       _addModel(arCoreController!,
//                           model: armchairs[index].models[0]);
//                       setState(() {
//                         _selectedModelUrl = armchairs[index].models[0];
//                         isMenuVisible = false;
//                         x.Get.snackbar('SELECTED ITEM', armchairs[index].name);
//                       });
//                     },
//                     child: Container(
//                       child: cacheImage(armchairs[index].images[0]),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       Container(
//         decoration: const BoxDecoration(color: Color(0xFFB0A291)),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             MediumText(
//               text: 'TABLES',
//               font: comorant,
//               size: 19.sp,
//             ),
//             Expanded(
//               child: MasonryGridView.count(
//                 itemCount: tables.length,
//                 crossAxisCount: 2,
//                 mainAxisSpacing: 3,
//                 cacheExtent: 100,
//                 crossAxisSpacing: 3,
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     onTap: () {
//                       _addModel(arCoreController!,
//                           model: tables[index].models[0]);
//                       setState(() {
//                         _selectedModelUrl = tables[index].models[0];
//                         isMenuVisible = false;
//                         x.Get.snackbar('SELECTED ITEM', tables[index].name);
//                       });
//                     },
//                     child: Container(
//                       child: cacheImage(tables[index].images[0]),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       Container(
//         decoration: const BoxDecoration(color: Color(0xFFB0A291)),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             MediumText(
//               text: 'BEDS',
//               font: comorant,
//               size: 19.sp,
//             ),
//             Expanded(
//               child: MasonryGridView.count(
//                 itemCount: beds.length,
//                 crossAxisCount: 2,
//                 mainAxisSpacing: 3,
//                 cacheExtent: 100,
//                 crossAxisSpacing: 3,
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     onTap: () {
//                       _addModel(arCoreController!,
//                           model: beds[index].models[0]);
//                       setState(() {
//                         _selectedModelUrl = beds[index].models[0];
//                         isMenuVisible = false;
//                         x.Get.snackbar('SELECTED ITEM', beds[index].name);
//                       });
//                     },
//                     child: Container(
//                       child: cacheImage(beds[index].images[0]),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       Container(
//         decoration: const BoxDecoration(color: Color(0xFFB0A291)),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             MediumText(
//               text: 'SOFAS',
//               font: comorant,
//               size: 19.sp,
//             ),
//             Expanded(
//               child: MasonryGridView.count(
//                 itemCount: sofas.length,
//                 crossAxisCount: 2,
//                 mainAxisSpacing: 3,
//                 cacheExtent: 100,
//                 crossAxisSpacing: 3,
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     onTap: () {
//                       _addModel(arCoreController!,
//                           model: sofas[index].models[0]);
//                       setState(() {
//                         _selectedModelUrl = sofas[index].models[0];
//                         isMenuVisible = false;
//                         x.Get.snackbar('SELECTED ITEM', sofas[index].name);
//                       });
//                     },
//                     child: Container(
//                       child: cacheImage(sofas[index].images[0]),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       Container(
//         decoration: const BoxDecoration(color: Color(0xFFB0A291)),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             MediumText(
//               text: 'LIGHTS',
//               font: comorant,
//               size: 19.sp,
//             ),
//             Expanded(
//               child: MasonryGridView.count(
//                 itemCount: lights.length,
//                 crossAxisCount: 2,
//                 mainAxisSpacing: 3,
//                 cacheExtent: 100,
//                 crossAxisSpacing: 3,
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     onTap: () {
//                       _addModel(arCoreController!,
//                           model: lights[index].models[0]);
//                       setState(() {
//                         _selectedModelUrl = lights[index].models[0];
//                         isMenuVisible = false;
//                         x.Get.snackbar('SELECTED ITEM', lights[index].name);
//                       });
//                     },
//                     child: Container(
//                       child: cacheImage(lights[index].images[0]),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     ]);
//   }
// }
// //Here

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'dart:async';
// import 'dart:developer';

// class ArView extends StatefulWidget {
//   const ArView({super.key});

//   @override
//   State<ArView> createState() => _ArViewState();
// }

// class _ArViewState extends State<ArView> {
//   static const platform = MethodChannel('com.example.my_ar_app/sceneview');

//   Future<void> _launchAR() async {
//     try {
//       await platform.invokeMethod(
//           'launchAR', {'modelUrl': 'https://example.com/your_model.glb'});
//     } on PlatformException catch (e) {
//       log("Failed to launch AR: '${e.message}'.");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: const Text('AR SceneView Example')),
//         body: Center(
//           child: ElevatedButton(
//             onPressed: _launchAR,
//             child: const Text('Launch AR Scene'),
//           ),
//         ));
//   }
// }
