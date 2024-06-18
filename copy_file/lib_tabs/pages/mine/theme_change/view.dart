import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../support_files/theme.dart';
import 'controller.dart';

class ThemeChangeView extends GetView<ThemeChangeController> {
  const ThemeChangeView({super.key});

  // 主视图
  Widget _buildView() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("ThemeChangeView ").paddingOnly(bottom: 20),
          ElevatedButton(
            onPressed: () {
              ThemeManager.to.changeDarkMode();
            },
            child: const Text('changeDarkMode'),
          ),
          ElevatedButton(
            onPressed: () {
              ThemeManager.to.changeTheme('dark');
            },
            child: const Text('changeMode - dark'),
          ),
          ElevatedButton(
            onPressed: () {
              ThemeManager.to.changeTheme('light');
            },
            child: const Text('changeMode - light'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("theme_change")),
      body: SafeArea(
        child: _buildView(),
      ),
    );
  }
}
