import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tayar_app/core/common/app/providers/tab_navigator.dart';

class PresistantView extends StatefulWidget {
  const PresistantView({super.key, this.body});

  final Widget? body;

  @override
  State<PresistantView> createState() => _PresistantViewState();
}

class _PresistantViewState extends State<PresistantView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.body ?? context.watch<TabNavigator>().currentPage.child;
  }

  @override
  bool get wantKeepAlive => true;
}
