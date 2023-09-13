import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'app.dart';
import 'services/app.dart';
import '/pages/home/home.dart';
import '/pages/mine/mine.dart';

enum TabbarType { home, mine }

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

  final _tabList = [
    {
      'title': '首页',
      'icon': 'home',
      'onTap': (BuildContext context) {
        Get.toNamed(kRouteHome);
      },
    },
    {
      'title': '我的',
      'icon': 'home',
      'onTap': (BuildContext context) {
        // if (!ref.read(isLoggedProvider)) {
        //   context.push('/login');
        // } else {
        Get.toNamed(kRouteMine);
        // }
      },
    },
  ];

  @override
  void initState() {
    super.initState();
    _children = List.generate(_tabList.length, (index) => const SizedBox());
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
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: _index,
              children: _children,
            ),
          ),
          _TabBar(
            index: _index,
            tabList: _tabList,
          ),
        ],
      ),
    );
  }
}

class _TabBar extends StatelessWidget {
  const _TabBar({
    Key? key,
    required this.index,
    required this.tabList,
  }) : super(key: key);

  final int index;
  final List tabList;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    List<Widget> children = [];

    for (int i = 0; i < tabList.length; i++) {
      children.add(
        Expanded(
          child: GestureDetector(
            onTap: () => (tabList[i]['onTap'] as Function).call(context),
            behavior: HitTestBehavior.opaque,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/ic_${tabList[i]['icon']}_${i == index ? 'slt' : 'nor'}.png',
                  width: 26,
                  height: 26,
                ),
                const SizedBox(height: 3),
                Text(
                  tabList[i]['title'] as String,
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

    return _AppEventlistener(
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
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
      ),
    );
  }
}

class _AppEventlistener extends HookWidget {
  const _AppEventlistener({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      final needLoginSub = AppService.bus.on<AppNeedToLogin>().listen((event) {
        // if (GoRouter.of(context).location != '/login') {
        //   ref.read(authNotifierProvider.notifier).logout();
        //   context
        //     ..go('/')
        //     ..push('/login');
        // }
      });
      return () {
        needLoginSub.cancel();
      };
    });
    return child;
  }
}
