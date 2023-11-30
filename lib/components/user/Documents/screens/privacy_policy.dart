import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    final path = Get.arguments;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SfPdfViewer.asset(
            '$path',
            canShowScrollHead: true,
            enableTextSelection: false,
            canShowScrollStatus: true,
            onDocumentLoaded: (PdfDocumentLoadedDetails details) {
              log('Total pages: ${details.document.pages.count}');
            },
            onDocumentLoadFailed: (e) {
              log('Error: ${e.error}');
              log('Description: ${e.description}');
            },
          ),
        ),
      ),
    );
  }
}
