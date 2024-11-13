import 'package:flutter/material.dart';
import 'package:pull_to_refresh_new/pull_to_refresh.dart';

class RefreshableWidget extends StatefulWidget {
  final Widget child;
  final Future<void> Function() onRefresh;
  final bool initialRefresh;

  const RefreshableWidget({
    super.key,
    required this.child,
    required this.onRefresh,
    this.initialRefresh = false,
  });

  @override
  _RefreshableWidgetState createState() => _RefreshableWidgetState();
}

class _RefreshableWidgetState extends State<RefreshableWidget> {
  late final RefreshController _refreshController;

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      onRefresh: _onRefresh,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
  }

  void _onRefresh() async {
    await widget.onRefresh();
    _refreshController.refreshCompleted();
  }
}
