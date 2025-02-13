import 'package:flutter/material.dart';

import '../../app.dart';
import 'controller.dart';

class MessageView extends BaseView<MessageController> {
  const MessageView({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return const AAppBar(title: 'MessageView');
  }

  @override
  Widget buildBody(BuildContext context) {
    return Center(
      child: Text("MessageView ${controller.count}"),
    );
  }
}
