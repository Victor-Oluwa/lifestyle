// import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
// import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
// import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
// import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
// import 'package:ar_flutter_plugin/models/ar_anchor.dart';
// import 'package:flutter/material.dart';
// import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
// import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
// import 'package:ar_flutter_plugin/datatypes/node_types.dart';
// import 'package:ar_flutter_plugin/datatypes/hittest_result_types.dart';
// import 'package:ar_flutter_plugin/models/ar_node.dart';
// import 'package:ar_flutter_plugin/models/ar_hittest_result.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:get/get.dart' as x;
// import 'package:get/get.dart';
// import 'package:lifestyle/Common/widgets/cache_image.dart';
// import 'package:lifestyle/Common/widgets/global_variables.dart';

// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:vector_math/vector_math_64.dart' as vec;
// import 'dart:developer' as dev;
// import '../../../../Common/widgets/app_constants.dart';
// import '../../../../Common/widgets/medium_text.dart';
// import '../../../../../models-classes/product.dart';
// import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

// class ArView extends ConsumerStatefulWidget {
//   const ArView({Key? key}) : super(key: key);
//   @override
//   ArViewState createState() => ArViewState();
// }

// class ArViewState extends ConsumerState<ArView> {
//   // late ARNode newNode;
//   ARNode? webObjectNode;
//   ArFlutterPlugin? arPluginController;
//   ARSessionManager? arSessionManager;
//   ARObjectManager? arObjectManager;
//   ARAnchorManager? arAnchorManager;

//   List<ARNode> nodes = [];
//   List<ARAnchor> anchors = [];

//   // Product product = x.Get.arguments;
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
//     // fetchSofa();
//     // fetchAccessories();
//     // fetchArmChairs();
//     // fetchBeds();
//     // fetchTables();
//     // fetchLight();
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
//               child: const Column(
//                 children: [
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
//               child: const Column(
//                 children: [
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
//             child: const Column(
//               children: [
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
//     // TutorialCoachMark tutorial =y
//     TutorialCoachMark(
//         targets: tagetList,
//         colorShadow: const Color(0xFF675E57).withOpacity(0.3),
//         onFinish: () {
//           dev.log("Tutorial finished");
//         },
//         onClickTarget: (target) {
//           dev.log("Clicked on target:$target");
//         },
//         onSkip: () {
//           dev.log('message');
//           return true;
//         }).show(context: context);
//   }

//   // fetchSofa() async {
//   //   final homeServices = ref.read(homeServiceProvider);
//   //   sofas = await homeServices.fetchProductCategory(
//   //       category: GlobalVariables.categoryTitles[0]);
//   //   setState(() {});
//   // }

//   // fetchArmChairs() async {
//   //   final homeServices = ref.read(homeServiceProvider);

//   //   armchairs = await homeServices.fetchProductCategory(
//   //       category: GlobalVariables.categoryTitles[1]);
//   // }

//   // fetchTables() async {
//   //   final homeServices = ref.read(homeServiceProvider);
//   //   tables = await homeServices.fetchProductCategory(
//   //       category: GlobalVariables.categoryTitles[2]);
//   // }

//   // fetchBeds() async {
//   //   final homeServices = ref.read(homeServiceProvider);
//   //   beds = await homeServices.fetchProductCategory(
//   //       category: GlobalVariables.categoryTitles[3]);
//   // }

//   // fetchAccessories() async {
//   //   final homeServices = ref.read(homeServiceProvider);
//   //   accessories = await homeServices.fetchProductCategory(
//   //       category: GlobalVariables.categoryTitles[4]);
//   // }

//   // fetchLight() async {
//   //   final homeServices = ref.read(homeServiceProvider);
//   //   lights = await homeServices.fetchProductCategory(
//   //       category: GlobalVariables.categoryTitles[5]);
//   // }

//   // Vector3 _scaleFactor = Vector3(0.5, 0.5, 0.5);
//   // final double angle = 0.0;

//   @override
//   void dispose() {
//     arSessionManager!.dispose();
//     super.dispose();
//   }

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
//           ARView(
//             onARViewCreated: onArViewCreated,
//             planeDetectionConfig: PlaneDetectionConfig.horizontal,
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: AnimatedContainer(
//               color: Colors.black,
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
//                       width: 38.w,
//                       height: 4.h,
//                       decoration: const BoxDecoration(color: Colors.black),
//                       child: MediumText(
//                         font: comorant,
//                         size: 15.sp,
//                         text: 'Back to Categories'.toUpperCase(),
//                         color: Colors.white,
//                       ),
//                     ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.topRight,
//             child: GestureDetector(
//               onTap: onRemoveEverything,
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
//           // Align(
//           //   alignment: Alignment.bottomCenter,
//           //   child: GestureDetector(
//           //     onTap: () {
//           //       startTutorial(context);
//           //     },
//           //     child: Container(
//           //       key: pickItemKey,
//           //       margin: EdgeInsets.only(top: 1.h, left: 2.w),
//           //       alignment: Alignment.center,
//           //       width: 6.h,
//           //       height: 6.h,
//           //       decoration: BoxDecoration(
//           //         borderRadius: BorderRadius.circular(50),
//           //         color: const Color(0xFF675E57),
//           //       ),
//           //       child: const Icon(Icons.add),
//           //     ),
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }

//   void onArViewCreated(
//       ARSessionManager arSessionManager,
//       ARObjectManager arObjectManager,
//       ARAnchorManager arAnchorManager,
//       ARLocationManager arLocationManager) {
//     this.arSessionManager = arSessionManager;
//     this.arObjectManager = arObjectManager;
//     this.arAnchorManager = arAnchorManager;
//     this.arSessionManager!.onInitialize(
//         showFeaturePoints: false,
//         showPlanes: true,
//         showWorldOrigin: false,
//         handlePans: true,
//         handleRotation: true,
//         handleTaps: true,
//         showAnimatedGuide: true);
//     this.arObjectManager!.onInitialize();
//     this.arSessionManager!.onPlaneOrPointTap = _onPlaneOrPointTapped;
//     this.arObjectManager!.onPanStart = onPanStarted;
//     this.arObjectManager!.onPanChange = onPanChanged;
//     this.arObjectManager!.onPanEnd = onPanEnded;
//     this.arObjectManager!.onRotationStart = onRotationStarted;
//     this.arObjectManager!.onRotationChange = onRotationChanged;
//     this.arObjectManager!.onRotationEnd = onRotationEnded;
//   }

//   Future<void> onRemoveEverything() async {
//     /*nodes.forEach((node) {
//       this.arObjectManager.removeNode(node);
//     });*/
//     for (var anchor in anchors) {
//       arAnchorManager!.removeAnchor(anchor);
//     }
//     anchors = [];
//   }

//   void _onPlaneOrPointTapped(List<ARHitTestResult> hitTestResults) async {
//     var singleHitTestResult = hitTestResults.firstWhere(
//         (hitTestResult) => hitTestResult.type == ARHitTestResultType.plane);
//     if (_selectedModelUrl != '') {
//       var newAnchor =
//           ARPlaneAnchor(transformation: singleHitTestResult.worldTransform);
//       bool? didAddAnchor = await arAnchorManager!.addAnchor(newAnchor);
//       if (didAddAnchor!) {
//         anchors.add(newAnchor);
//         // Add note to anchor
//         var newNode = ARNode(
//           type: NodeType.webGLB,
//           uri: _selectedModelUrl,
//           scale: vec.Vector3(1.0, 1.0, 1.0),
//           position: vec.Vector3(0.0, 0.0, 0.0),
//           rotation: vec.Vector4(1.0, 0.0, 0.0, 0.0),
//         );
//         bool? didAddNodeToAnchor =
//             await arObjectManager!.addNode(newNode, planeAnchor: newAnchor);
//         if (didAddNodeToAnchor!) {
//           nodes.add(newNode);
//         } else {
//           arSessionManager!.onError("Adding Node to Anchor failed");
//         }
//       } else {
//         arSessionManager!.onError("Adding Anchor failed");
//       }
//     } else {
//       x.Get.snackbar('Empty Node', 'Select a product to add');
//     }
//   }

//   // Future<void> launchModel(String modelUrl) async {

//   //   if (webObjectNode != null) {
//   //     arObjectManager!.removeNode(webObjectNode!);
//   //     webObjectNode = null;
//   //   } else {
//   //     var newNode = ARNode(
//   //       type: NodeType.webGLB,
//   //       uri: modelUrl,
//   //       scale: vec.Vector3(0.2, 0.2, 0.2),
//   //       position: vec.Vector3(0.0, 0.0, 0.0),
//   //       rotation: vec.Vector4(1.0, 0.0, 0.0, 0.0),
//   //     );

//   //     bool? didAddNode = await arObjectManager!.addNode(newNode);
//   //     if (didAddNode!) {
//   //       nodes.add(newNode);
//   //     } else {
//   //       arSessionManager!.onError("Adding Node failed");
//   //     }
//   //   }
//   // }

//   onPanStarted(String nodeName) {
//     dev.log("Started panning node $nodeName");
//   }

//   onPanChanged(String nodeName) {
//     dev.log("Continued panning node $nodeName");
//   }

//   onPanEnded(String nodeName, Matrix4 newTransform) {
//     dev.log("Ended panning node $nodeName");
//     // final pannedNode = nodes.firstWhere((element) => element.name == nodeName);

//     /*
//     * Uncomment the following command if you want to keep the transformations of the Flutter representations of the nodes up to date
//     * (e.g. if you intend to share the nodes through the cloud)
//     */
//     // pannedNode.transform = newTransform;
//   }

//   onRotationStarted(String nodeName) {
//     dev.log("Started rotating node $nodeName");
//   }

//   onRotationChanged(String nodeName) {
//     dev.log("Continued rotating node $nodeName");
//   }

//   onRotationEnded(String nodeName, Matrix4 newTransform) {
//     dev.log("Ended rotating node $nodeName");
//     // final rotatedNode = nodes.firstWhere((element) => element.name == nodeName);

//     /*
//     * Uncomment the following command if you want to keep the transformations of the Flutter representations of the nodes up to date
//     * (e.g. if you intend to share the nodes through the cloud)
//     */
//     // rotatedNode.transform = newTransform;
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
//         decoration: const BoxDecoration(color: Colors.transparent),
//         margin: EdgeInsets.only(left: 1.w, right: 1.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             MediumText(
//               text: '',
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
//         decoration: const BoxDecoration(color: Colors.transparent),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             MediumText(
//               text: '',
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
//         decoration: const BoxDecoration(color: Colors.transparent),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             MediumText(
//               text: '',
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
//         decoration: const BoxDecoration(color: Colors.transparent),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             MediumText(
//               text: '',
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
//         decoration: const BoxDecoration(color: Colors.transparent),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             MediumText(
//               text: '',
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
//         decoration: const BoxDecoration(color: Colors.transparent),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             MediumText(
//               text: '',
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


























