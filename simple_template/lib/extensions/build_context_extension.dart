import 'package:flutter/cupertino.dart';

// import '/utils/permission_util.dart';
// import 'package:wechat_assets_picker/wechat_assets_picker.dart';
// import 'package:wechat_camera_picker/wechat_camera_picker.dart';

extension BuildContextExtension on BuildContext {
  /// 顶级方法关闭键盘
  // void keyboardDissmissForce() {
  // FocusScope.of(this).requestFocus(FocusNode());
  // SystemChannels.textInput.invokeMethod('TextInput.hide');
  // }

  /// 关闭键盘
  void keyboardDissmiss() {
    FocusScopeNode currentFocus = FocusScope.of(this);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  Future<T?> pushPage<T>(Widget widget, {bool fullscreenDialog = false}) {
    return Navigator.push<T>(
      this,
      CupertinoPageRoute<T>(
        builder: (context) => widget,
        fullscreenDialog: fullscreenDialog,
      ),
    );
  }
}

// extension BuildContextPicker on BuildContext {
//   /// 图片选择
//   Future<List<AssetEntity>?> picker({
//     int maxAssets = 1,
//     List<AssetEntity>? selectedAssets,
//   }) async {
//     final state = await PermissionUtil().requestPhoto();

//     if (!state) {
//       return null;
//     }

//     return await AssetPicker.pickAssets(
//       this,
//       pickerConfig: AssetPickerConfig(
//         maxAssets: maxAssets,
//         selectedAssets: selectedAssets,
//         requestType: RequestType.image,
//       ),
//     );
//   }

//   /// 相机
//   Future<AssetEntity?> camera({
//     int maxAssets = 1,
//     List<AssetEntity>? selectedAssets,
//   }) async {
//     final state = await PermissionUtil().requestCamera();

//     if (!state) {
//       return null;
//     }

//     return await CameraPicker.pickFromCamera(
//       this,
//       pickerConfig: const CameraPickerConfig(),
//     );
//   }
// }
