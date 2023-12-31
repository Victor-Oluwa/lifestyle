import 'dart:developer';
import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:lifestyle/Common/colors/lifestyle_colors.dart';

import '../../../../Common/widgets/floating_text_editor.dart';
import '../../../../Common/widgets/medium_text.dart';

final noCallToActionProvider = StateProvider((ref) => false);
final launchUrlActionProvider = StateProvider((ref) => false);
final navigateToScreenActionProvider = StateProvider((ref) => false);

final launchUrlValueProvider = StateProvider((ref) => '');
final navigateValueProvider = StateProvider((ref) => '');

final selectedActionProvider = StateProvider((ref) => 'No-Action');
final selectedActionValueProvider = StateProvider((ref) => 'No-Data');

class SelectActionScreen extends ConsumerStatefulWidget {
  const SelectActionScreen({super.key});

  @override
  ConsumerState<SelectActionScreen> createState() => _SelectActionScreenState();
}

class _SelectActionScreenState extends ConsumerState<SelectActionScreen> {
  TextEditingController urlController = TextEditingController();

  final FocusNode urlFocusNode = FocusNode();

  List<String> screenList = [
    'New Products Screen',
    'Sofa Screen',
    'Armchairs Screen',
    'Tables Screen',
    'Accessories Screen',
    'Beds Screen',
    'AR Screen',
  ];

  @override
  void initState() {
    urlFocusNode.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    urlFocusNode.dispose();
    urlController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final noCallToAction = ref.watch(noCallToActionProvider);
    final launchUrl = ref.watch(launchUrlActionProvider);
    final navigateAction = ref.watch(navigateToScreenActionProvider);

    final navigateActionValue = ref.watch(navigateValueProvider);
    final launchUrlActionValue = ref.watch(launchUrlValueProvider);
    return Scaffold(
      backgroundColor: LifestyleColors.kTaupeBackground,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Container(
                  alignment: Alignment.center,
                  color: LifestyleColors.kTaupeBackground,
                  width: 90.w,
                  child: Material(
                    color: LifestyleColors.kTaupeBackground,
                    elevation: 20,
                    shadowColor: LifestyleColors.shadowColor,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(1.h),
                      child: Column(
                        children: [
                          buildLaunchUrlAction(
                            navigateActionProvider: navigateAction,
                            noCallToAction: noCallToAction,
                            launchUrlAction: launchUrl,
                          ),
                          SizedBox(height: 6.h),
                          buildNavigateAction(
                              noCallToAction: noCallToAction,
                              launchUrlAction: launchUrl,
                              screenList: screenList,
                              navigateAction: navigateAction),
                          SizedBox(height: 6.h),
                          noAction(
                            launchUrlAction: launchUrl,
                            navigateAction: navigateAction,
                            noCallToAction: noCallToAction,
                          ),
                          urlFocusNode.hasFocus
                              ? SizedBox(height: 7.h)
                              : const SizedBox(height: 0.0)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: IconButton(
                onPressed: () {
                  if (launchUrl == true && urlController.text.isNotEmpty) {
                    ref.read(launchUrlValueProvider.notifier).state =
                        urlController.text.trim();
                  } else if (noCallToAction == true) {
                    ref.invalidate(navigateValueProvider);
                    ref.invalidate(launchUrlValueProvider);
                  }

                  List<Map<String, dynamic>> actionOptions = [
                    {'Navigate': navigateAction},
                    {'Launch-Url': launchUrl},
                    {'No-Action': noCallToAction}
                  ];
                  try {
                    final selectedAction = actionOptions
                        .firstWhere((option) => option.values.contains(true),
                            orElse: () => <String, bool>{})
                        .keys
                        .first;

                    if (selectedAction == 'Navigate' &&
                        navigateActionValue.isNotEmpty) {
                      ref.read(selectedActionProvider.notifier).state =
                          selectedAction;

                      ref.read(selectedActionValueProvider.notifier).state =
                          navigateActionValue;

                      log(navigateActionValue);
                    }

                    if (selectedAction == 'Launch-Url' &&
                        launchUrlActionValue.isNotEmpty) {
                      ref.read(selectedActionProvider.notifier).state =
                          selectedAction;

                      ref.read(selectedActionValueProvider.notifier).state =
                          launchUrlActionValue;

                      log(launchUrlActionValue);
                    }

                    if (selectedAction == 'No-Action') {
                      ref.invalidate(selectedActionProvider);
                      ref.invalidate(selectedActionValueProvider);
                    }
                  } catch (e) {
                    ref.invalidate(navigateValueProvider);
                    ref.invalidate(launchUrlValueProvider);
                    ref.invalidate(selectedActionProvider);
                    ref.invalidate(selectedActionValueProvider);
                  }
                },
                icon: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 7.h,
                  color: LifestyleColors.black,
                  child: const MediumText(
                      color: LifestyleColors.white, text: 'SAVE'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container buildNavigateAction({
    required List<String> screenList,
    required bool navigateAction,
    required bool launchUrlAction,
    required bool noCallToAction,
  }) {
    return Container(
      height: 18.h,
      color: LifestyleColors.kTaupeDark.withOpacity(0.5),
      // padding: EdgeInsets.all(1.h),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    if (navigateAction == false) {
                      ref.read(navigateToScreenActionProvider.notifier).state =
                          true;
                      ref.invalidate(noCallToActionProvider);
                      ref.invalidate(launchUrlActionProvider);

                      return;
                    } else {
                      ref.read(navigateToScreenActionProvider.notifier).state =
                          false;
                    }
                  },
                  icon: navigateAction
                      ? const Icon(Icons.check_box)
                      : const Icon(Icons.check_box_outline_blank)),
              const MediumText(
                  color: LifestyleColors.white,
                  text: 'Navigate to a particular screen'),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.h),
            child: CustomDropdownWidget(
              screenList: screenList,
              onChanged: (value) {
                if (navigateAction == true) {
                  ref.read(navigateValueProvider.notifier).state = value;
                  return;
                }

                ref.invalidate(navigateValueProvider);
              },
            ),
          )
        ],
      ),
    );
  }

  Container buildLaunchUrlAction({
    required bool navigateActionProvider,
    required bool launchUrlAction,
    required bool noCallToAction,
  }) {
    return Container(
      height: 18.h,
      color: LifestyleColors.kTaupeDark.withOpacity(0.5),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                  splashRadius: 0.0001,
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    if (launchUrlAction == false) {
                      ref.read(launchUrlActionProvider.notifier).state = true;
                      ref.invalidate(noCallToActionProvider);
                      ref.invalidate(navigateToScreenActionProvider);

                      return;
                    } else {
                      ref.read(launchUrlActionProvider.notifier).state = false;
                    }
                  },
                  icon: launchUrlAction
                      ? const Icon(Icons.check_box)
                      : const Icon(Icons.check_box_outline_blank)),
              const MediumText(
                  color: LifestyleColors.white, text: 'Launch a URL'),
            ],
          ),
          SizedBox(height: 1.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.h),
            child: FloatingTextEditor(
              onChanged: (value) {
                if (launchUrlAction == true) {
                  ref.read(launchUrlValueProvider.notifier).state =
                      value.trim();
                }
                // ref.invalidate(launchUrlValueProvider);
              },
              focusNode: urlFocusNode,
              readOnly: !launchUrlAction,
              controller: urlController,
              label: const MediumText(text: 'Enter URL'),
              onFieldSubmitted: (value) {
                if (launchUrlAction == true) {
                  ref.read(launchUrlValueProvider.notifier).state =
                      value.trim();
                }
                // ref.invalidate(launchUrlValueProvider);
              },
            ),
          )
        ],
      ),
    );
  }

  Container noAction({
    required bool navigateAction,
    required bool launchUrlAction,
    required bool noCallToAction,
  }) {
    return Container(
      color: LifestyleColors.kTaupeDarkened.withOpacity(0.5),
      child: Row(
        children: [
          IconButton(
            padding: const EdgeInsets.all(0.0),
            onPressed: () {
              if (noCallToAction == false) {
                ref.read(noCallToActionProvider.notifier).state = true;
                ref.invalidate(navigateToScreenActionProvider);
                ref.invalidate(launchUrlActionProvider);
                return;
              } else {
                ref.read(noCallToActionProvider.notifier).state = false;
              }
            },
            icon: noCallToAction == true
                ? const Icon(Icons.check_box)
                : const Icon(Icons.check_box_outline_blank),
          ),
          SizedBox(width: 2.w),
          const MediumText(
              color: LifestyleColors.white, text: 'No call to action')
        ],
      ),
    );
  }
}

class CustomDropdownWidget extends StatelessWidget {
  const CustomDropdownWidget({
    Key? key,
    required this.screenList,
    this.onChanged,
  }) : super(key: key);
  final List<String> screenList;

  final dynamic Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return CustomDropdown(
        closedBorderRadius: const BorderRadius.all(Radius.zero),
        expandedBorderRadius: const BorderRadius.all(Radius.zero),
        items: screenList,
        initialItem: screenList[0],
        hintText: 'Choose screen',
        expandedFillColor: LifestyleColors.kTaupeDark,
        closedFillColor: LifestyleColors.kTaupeDark,
        onChanged: onChanged);
  }
}
