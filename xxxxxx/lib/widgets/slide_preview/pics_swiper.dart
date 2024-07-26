import 'package:flutter/material.dart';

import 'package:extended_image/extended_image.dart';
import 'package:get/get.dart';

import '../../support_files/theme.dart';
import '/support_files/text_style.dart';
import '/utils/image_save.dart';
import '/widgets/common/gaps.dart';
import '/widgets/common/toast.dart';
import '/widgets/dialogs/common_alert.dart';
import 'hero.dart';

class PreviewImages {
  static show(
    List<String> images, {
    int index = 0,
  }) {
    if (images.isEmpty) {
      return;
    }
    Navigator.of(Get.context!).push(
      MaterialPageRoute(
        builder: (context) {
          return SimplePicSwiper(url: images[index], images: images);
        },
      ),
    );
    // Get.to(
    //   () => SimplePicsWiper(url: images[index], images: images),
    //   transition: Transition.fadeIn,
    // );
  }
}

class SimplePicSwiper extends StatefulWidget {
  const SimplePicSwiper({super.key, required this.url, required this.images});
  final String url;
  final List<String> images;
  @override
  State<SimplePicSwiper> createState() => _SimplePicSwiperState();
}

class _SimplePicSwiperState extends State<SimplePicSwiper> {
  GlobalKey<ExtendedImageSlidePageState> slidePagekey =
      GlobalKey<ExtendedImageSlidePageState>();
  final _index = ValueNotifier(0);

  final List<int> _cachedIndexes = <int>[];

  @override
  void initState() {
    super.initState();
    _index.value = widget.images.indexOf(widget.url);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final int index = widget.images.indexOf(widget.url);
    _preloadImage(index - 1);
    _preloadImage(index + 1);
  }

  void _preloadImage(int index) {
    if (_cachedIndexes.contains(index)) {
      return;
    }
    if (0 <= index && index < widget.images.length) {
      final String url = widget.images[index];
      if (url.startsWith('https:')) {
        precacheImage(ExtendedNetworkImageProvider(url, cache: true), context);
      }

      _cachedIndexes.add(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: ValueListenableBuilder(
            valueListenable: _index,
            builder: (context, value, child) {
              return widget.images.length > 1
                  ? Text('${_index.value + 1}/${widget.images.length}',
                      style: myAppColors.text1.font_15)
                  : Gaps.blank;
            },
          ),
        ),
        backgroundColor: Colors.black,
        // bottomNavigationBar: BottomAppBar(
        //   color: Colors.white,
        //   elevation: 0,
        //   padding: EdgeInsets.zero,
        //   child: Padding(
        //     padding: const EdgeInsets.only(left: 20.0, right: 10),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         if (widget.images.length > 1)
        //           Text('${_index + 1}/${widget.images.length}',
        //               style: myAppColors.com000.font_15),
        //         Gaps.expand,
        //         IconButton(
        //           onPressed: () async {
        //             showLoading();
        //             await ImageSaver.urlSave(widget.images[_index]);
        //           },
        //           icon: const Icon(
        //             Icons.download,
        //             color: Colors.black,
        //             size: 20,
        //           ),
        //         )
        //       ],
        //     ),
        //   ),
        // ),
        body: ExtendedImageSlidePage(
          key: slidePagekey,
          slideAxis: SlideAxis.vertical,
          slideType: SlideType.onlyImage,
          resetPageDuration: const Duration(milliseconds: 300),
          slidePageBackgroundHandler: (offset, pageSize) {
            return Colors.black;
          },
          child: GestureDetector(
            child: ExtendedImageGesturePageView.builder(
              controller: ExtendedPageController(
                initialPage: widget.images.indexOf(widget.url),
                // pageSpacing: 50,
                shouldIgnorePointerWhenScrolling: false,
              ),
              itemCount: widget.images.length,
              onPageChanged: (int page) {
                _preloadImage(page - 1);
                _preloadImage(page + 1);

                _index.value = page;
              },
              itemBuilder: (BuildContext context, int index) {
                final String url = widget.images[index];

                return url == 'This is an video'
                    ? ExtendedImageSlidePageHandler(
                        child: Material(
                          child: Container(
                            alignment: Alignment.center,
                            color: Colors.yellow,
                            child: const Text('This is an video'),
                          ),
                        ),

                        ///make hero better when slide out
                        heroBuilderForSlidingPage: (Widget result) {
                          return Hero(
                            tag: url,
                            child: result,
                            flightShuttleBuilder: (BuildContext flightContext,
                                Animation<double> animation,
                                HeroFlightDirection flightDirection,
                                BuildContext fromHeroContext,
                                BuildContext toHeroContext) {
                              final Hero hero =
                                  (flightDirection == HeroFlightDirection.pop
                                      ? fromHeroContext.widget
                                      : toHeroContext.widget) as Hero;

                              return hero.child;
                            },
                          );
                        },
                      )
                    : HeroWidget(
                        tag: url,
                        slideType: SlideType.wholePage,
                        slidePagekey: slidePagekey,
                        child: ExtendedImage.network(
                          url,
                          enableSlideOutPage: true,
                          fit: BoxFit.contain,
                          mode: ExtendedImageMode.gesture,
                          initGestureConfigHandler: (ExtendedImageState state) {
                            return GestureConfig(
                              //you must set inPageView true if you want to use ExtendedImageGesturePageView
                              inPageView: true,
                              initialScale: 1,
                              maxScale: 5.0,
                              animationMaxScale: 6.0,
                              initialAlignment: InitialAlignment.center,
                            );
                          },
                        ),
                      );
              },
            ),
            onLongPress: () {
              Get.dialog(
                AlertActionsSaveView(
                  onSave: () async {
                    showLoading();
                    await ImageSaver.urlSave(widget.images[_index.value]);
                  },
                ),
                barrierColor: context.appColors.barrierColor,
              );
            },
            onTap: () {
              slidePagekey.currentState!.popPage();
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
