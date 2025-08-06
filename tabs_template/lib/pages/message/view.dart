import 'dart:math';

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
    return SpeedyPagedList.separated(
      controller: controller as MessageController,
      itemBuilder: (context, index, item) {
        return Container(
            color: Color.fromARGB(255, Random().nextInt(255),
                Random().nextInt(255), Random().nextInt(255)),
            height: 30,
            child: Text('$index'));
      },
      separatorBuilder: (context, index) => Gaps.h10,
    );
  }
}
