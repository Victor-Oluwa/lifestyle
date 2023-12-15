import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lifestyle/Common/colors/lifestyle_colors.dart';

import '../../../../Common/strings/strings.dart';
import '../screens/privacy_policy.dart';

class DocumentsPageDropdown extends StatefulWidget {
  const DocumentsPageDropdown({super.key});

  @override
  State<DocumentsPageDropdown> createState() => _DocumentsPageDropdownState();
}

class _DocumentsPageDropdownState extends State<DocumentsPageDropdown> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: PopupMenuButton<String>(
        color: LifestyleColors.kTaupeDarkened,
        onSelected: (String result) {
          if (result == 'Policy') {
            Get.to(() => const PrivacyPolicy(),
                arguments: LifestyleStrings.privacyPolicyAssetPath);
          }
          log('Selected: $result');
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: 'About',
            child: Text('About Lifestyle'),
          ),
          PopupMenuItem<String>(
            value: 'Policy',
            child: const Text('Privacy Policy'),
            onTap: () {},
          ),
        ],
        icon: const Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
      ),
    );
  }
}
