import 'package:flutter/material.dart';
import 'package:get/get.dart' as x;
import 'package:lifestyle/models-classes/product.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class ArModel extends StatefulWidget {
  const ArModel({super.key});

  @override
  State<ArModel> createState() => _ArModelState();
}

class _ArModelState extends State<ArModel> {
  Product arg = x.Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF675E57),
      body: Container(
        color: Colors.white.withOpacity(0.5),
        child: SafeArea(
          child: Center(
            child: ModelViewer(
              iosSrc: arg.models[0],
              src: arg.models[0],
              arModes: const ['scene-viewer', 'webxr', 'quick-look'],
              ar: false,
              autoRotate: true,
              // iosSrc: 'assets/scene.gltf',
            ),
          ),
        ),
      ),
    );
  }
}
