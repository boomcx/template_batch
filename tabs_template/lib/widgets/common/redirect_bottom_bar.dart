import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

/// 重定向底部导航栏
class RedirectBottomNavBar extends StatelessWidget {
  const RedirectBottomNavBar({
    required this.navBarConfig,
    required this.onRedirected,
    super.key,
    this.navBarDecoration = const NavBarDecoration(),
  });

  final NavBarConfig navBarConfig;
  final NavBarDecoration navBarDecoration;

  /// 重定向底部导航栏操作
  /// 
  /// onRedirected返回值为true打开重定向, 否则取消重定向（正常触发业务逻辑）
  final Future<bool?> Function(int index) onRedirected;

  Widget _buildItem(ItemConfig item, bool isSelected) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: IconTheme(
              data: IconThemeData(
                size: item.iconSize,
                color: isSelected
                    ? item.activeForegroundColor
                    : item.inactiveForegroundColor,
              ),
              child: isSelected ? item.icon : item.inactiveIcon,
            ),
          ),
          if (item.title != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Material(
                type: MaterialType.transparency,
                child: FittedBox(
                  child: Text(
                    item.title!,
                    style: item.textStyle.apply(
                      color: isSelected
                          ? item.activeForegroundColor
                          : item.inactiveForegroundColor,
                    ),
                  ),
                ),
              ),
            ),
        ],
      );

  @override
  Widget build(BuildContext context) => DecoratedNavBar(
        decoration: navBarDecoration,
        filter: navBarDecoration.filter,
        opacity: navBarDecoration.color?.opacity ?? 1,
        height: navBarConfig.navBarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: navBarConfig.items.map((item) {
            final int index = navBarConfig.items.indexOf(item);
            return Expanded(
              child: InkWell(
                onTap: () async {
                  if (await onRedirected.call(index) == true) {
                    return;
                  }
                  navBarConfig.onItemSelected(index);
                },
                child: _buildItem(
                  item,
                  navBarConfig.selectedIndex == index,
                ),
              ),
            );
          }).toList(),
        ),
      );
}
