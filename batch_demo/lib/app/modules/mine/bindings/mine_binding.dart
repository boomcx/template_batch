import 'package:get/get.dart';

import '../controllers/mine_controller.dart';

class MineBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut<MineController>(
        () => MineController(),
      )
    ];
  }
}
