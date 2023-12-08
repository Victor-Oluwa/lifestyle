import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart' as x;
import 'package:lifestyle/Common/colors/lifestyle_colors.dart';
import 'package:lifestyle/Common/widgets/processing_indicator.dart';

import 'package:lifestyle/state/providers/actions/provider_operations.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../provider/search_provider.dart';
import '../widget/search_widget.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({
    super.key,
  });

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  String query = x.Get.arguments;
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    Future(() {
      ref.read(searchFunctionProvider).setQueryValue(query: query);
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final serchFunction = ref.read(searchFunctionProvider);
    final isProcessing = ref.watch(isProcessingProvider);
    final query = ref.watch(queryProvider);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: buildAppbar(),
        backgroundColor: const Color(0xFFB0A291),
        body: Stack(
          children: [
            serchFunction.buildSearchView(
                ref: ref, query: query, controller: controller),
            isProcessing ? const ProcessingIndicator() : const Text(''),
          ],
        ));
  }

  AppBar buildAppbar() {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      elevation: 0,
      leading: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 2.w, top: 0.5.h, bottom: 0.5.h),
          color: LifestyleColors.kTaupeDark,
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios))),
      backgroundColor: Colors.transparent,
      title: SearchWidget(
          horizontalPadding: 0.0,
          submmit: (query) {
            ref.watch(queryProvider.notifier).update((state) => query);
            ref.invalidate(searchResultProvider);
          },
          pressed: () {
            final String query = controller.text.trim();
            ref.watch(queryProvider.notifier).update((state) => state = query);
            ref.invalidate(searchResultProvider);
          },
          controller: controller,
          ref: ref),
    );
  }
}
