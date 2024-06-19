import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../slide_preview/pics_swiper.dart';

class NetworkAssets extends StatelessWidget {
  const NetworkAssets(
    this.url, {
    super.key,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.radius,
    this.placeholder,
    this.error,
    this.alignment = Alignment.center,
    this.isPreview = false,
  });

  final String url;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final double? radius;
  final Widget? placeholder;
  final Widget? error;
  final Alignment alignment;
  final bool isPreview;

  @override
  Widget build(BuildContext context) {
    Widget placeholder = this.placeholder ??
        Icon(
          Icons.image_not_supported,
          size: (width ?? 0) * 0.8,
        );
    if (width != null &&
        height != null &&
        width != double.infinity &&
        height != double.infinity) {
      placeholder = Icon(
        Icons.image_not_supported,
        size: (width ?? 0) * 0.8,
      );
    }

    Widget errorIcon = error ??
        Icon(
          Icons.image_not_supported,
          size: (width ?? 0) * 0.8,
        );

    if (url.isEmpty || Uri.tryParse(url) == null) {
      return radius != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(radius!),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radius!),
                child: errorIcon,
              ),
            )
          : errorIcon;
    }

    // Widget child = CachedNetworkImage(
    //   imageUrl: url,
    //   fit: fit,
    //   width: width,
    //   height: height,
    //   alignment: alignment,
    //   // useOldImageOnUrlChange: true,
    //   // placeholder: (context, url) => placeholder,
    //   errorWidget: (context, url, error) => errorIcon,
    //   progressIndicatorBuilder: (context, url, progress) {
    //     return placeholder;
    //   },
    // );

    Widget child = ExtendedImage.network(
      url,
      fit: fit,
      width: width,
      height: height,
      alignment: alignment,
      // useOldImageOnUrlChange: true,
      // placeholder: (context, url) => placeholder,
      // border: Border.all(color: Colors.red, width: 1.0),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      borderRadius: BorderRadius.circular(radius ?? 0),
      shape: BoxShape.rectangle,
      loadStateChanged: (state) {
        if (state.extendedImageLoadState == LoadState.failed) {
          return errorIcon;
        }
        if (state.extendedImageLoadState == LoadState.loading) {
          return placeholder;
        }
        return null;
      },
    );

    // if (radius != null) {
    //   child = ClipRRect(
    //     borderRadius: BorderRadius.circular(radius!),
    //     child: child,
    //   );
    // }

    return GestureDetector(
      onTap: isPreview
          ? () {
              if (url.isNotEmpty) {
                // Get.to(() => ImagePreview([url]));
                Get.to(() => SimplePicSwiper(url: url, images: [url]));
              }
            }
          : null,
      child: child,
    );
  }
}
