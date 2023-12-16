import 'dart:developer' as console;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lifestyle/Common/colors/lifestyle_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'medium_text.dart';

final customCacheManager = CacheManager(
  Config(
    'customCacheKey',
    stalePeriod: const Duration(days: 15),
    maxNrOfCacheObjects: 100,
  ),
);

CachedNetworkImage networkImageCacher(
  String url, {
  Color placeHolderColor = LifestyleColors.white,
}) {
  return CachedNetworkImage(
    fit: BoxFit.cover,
    cacheManager: customCacheManager,
    imageUrl: url,
    placeholder: (context, url) => FaIcon(
      color: placeHolderColor,
      FontAwesomeIcons.barsProgress,
    ),
    errorWidget: (context, url, error) => const Center(
      child: MediumText(text: 'Failed to load image'),
    ),
  );
}

Future<bool> clearCache(String imageUrl) async {
  return await CachedNetworkImage.evictFromCache(imageUrl).then((value) {
    console.log('Cache cleared: $value');
    return value;
  });
}

bool allowClearCache = false;
