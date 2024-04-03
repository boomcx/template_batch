import 'package:flutter/widgets.dart';

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/ic_home_nor.png
  AssetGenImage get icHomeNor =>
      const AssetGenImage('assets/images/ic_home_nor.png');

  /// File path: assets/images/ic_home_slt.png
  AssetGenImage get icHomeSlt =>
      const AssetGenImage('assets/images/ic_home_slt.png');

  /// File path: assets/images/ic_mine_nor.png
  AssetGenImage get icMineNor =>
      const AssetGenImage('assets/images/ic_mine_nor.png');

  /// File path: assets/images/ic_mine_slt.png
  AssetGenImage get icMineSlt =>
      const AssetGenImage('assets/images/ic_mine_slt.png');

  /// File path: assets/images/ic_nav_back.png
  AssetGenImage get icNavBack =>
      const AssetGenImage('assets/images/ic_nav_back.png');

  /// List of all assets
  List<AssetGenImage> get values =>
      [icHomeNor, icHomeSlt, icMineNor, icMineSlt, icNavBack];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
