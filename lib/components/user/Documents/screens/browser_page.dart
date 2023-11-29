import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:lifestyle/Common/widgets/medium_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Browser extends StatefulWidget {
  const Browser({super.key});

  @override
  State<Browser> createState() => _BrowserState();
}

class _BrowserState extends State<Browser> {
  String page = '';
  @override
  void initState() {
    super.initState();
    page = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF675E57),
      appBar: AppBar(
        backgroundColor: const Color(0xFF675E57),
        elevation: 0,
        title: MediumText(
          size: 19.sp,
          text: 'Document View',
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(page)),
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
                transparentBackground: false,
                useShouldOverrideUrlLoading: true,
                mediaPlaybackRequiresUserGesture: false,
                allowFileAccessFromFileURLs: true,
                useOnLoadResource: true,
                allowUniversalAccessFromFileURLs: true),
          ),
        ),
      ),
    );
  }
}
