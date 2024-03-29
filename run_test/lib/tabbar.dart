import 'dart:math';

import 'package:flutter/material.dart';
import 'app.dart';
import '/pages/home/home.dart';
import '/pages/mine/mine.dart';

enum TabbarType {
  home,
  mine;

  String get title {
    switch (this) {
      case TabbarType.home:
        return '首页';
      case TabbarType.mine:
        return '我的';
    }
  }

  String get icon {
    switch (this) {
      case TabbarType.home:
        return 'home';
      case TabbarType.mine:
        return 'mine';
    }
  }

  onTap(BuildContext context) {
    switch (this) {
      case TabbarType.home:
        Get.toNamed(kRouteHome);
        break;
      case TabbarType.mine:
        Get.toNamed(kRouteMine);
        break;
    }
  }

  Widget get body {
    switch (this) {
      case TabbarType.home:
        return const HomeView();
      case TabbarType.mine:
        return const MineView();
    }
  }
}

class TabbarScaffold extends StatefulWidget {
  const TabbarScaffold({
    super.key,
    required this.body,
    this.type = TabbarType.home,
  });

  final Widget body;
  final TabbarType type;

  @override
  State<TabbarScaffold> createState() => _TabbarScaffoldState();
}

class _TabbarScaffoldState extends State<TabbarScaffold> {
  int _index = -1;
  List<Widget> _children = [];

  @override
  void initState() {
    super.initState();
    _children =
        List.generate(TabbarType.values.length, (index) => const SizedBox());
    _updateChildren();
    // SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
    //   mobLinkMount();
    // });
  }

  void _updateChildren() {
    if (widget.type.index != _index) {
      _index = widget.type.index;
      _children[_index] = widget.body;
    }
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant TabbarScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.type != widget.type) {
      _updateChildren();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        elevation: 0,
        height: max(54.w, 54),
        child: _TabBar(
          index: _index,
          tabList: TabbarType.values,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: _index,
              children: _children,
            ),
          ),
        ],
      ),
    );
  }
}

class _TabBar extends StatelessWidget {
  const _TabBar({
    super.key,
    required this.index,
    required this.tabList,
  });

  final int index;
  final List<TabbarType> tabList;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    List<Widget> children = [];

    for (int i = 0; i < tabList.length; i++) {
      children.add(
        Expanded(
          child: GestureDetector(
            onTap: () => tabList[i].onTap.call(context),
            behavior: HitTestBehavior.opaque,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/ic_${tabList[i].icon}_${i == index ? 'slt' : 'nor'}.png',
                  width: 26,
                  height: 26,
                ),
                const SizedBox(height: 3),
                Text(
                  tabList[i].title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: i == index ? colors.primary : colors.text4,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
            )
          ],
        ),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              // const ExtensivePlayer(),
              SizedBox(
                height: 50,
                child: Row(
                  children: children,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
