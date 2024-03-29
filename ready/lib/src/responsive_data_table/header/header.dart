part of responsive_data_table;

class _Header<T, S extends BaseReadyListState<T>,
    TController extends ReadyListController<T, S>> extends StatelessWidget {
  final ResponsiveDataTableType type;
  final TController controller;
  final bool sliver;
  const _Header(
      {Key? key,
      required this.type,
      required this.controller,
      this.sliver = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var options = context.dependOnInheritedWidgetOfExactType<
        ResponsiveDataTable<T, S, TController>>()!;
    bool hasPageInfo = PageInfo.mayBeOf(context) != null;
    if (options.actions.isEmpty &&
        options.filters.isEmpty &&
        options.selectionButton == null &&
        type != ResponsiveDataTableType.table &&
        hasPageInfo) return const SliverToBoxAdapter();
    if (sliver) {
      return SliverPersistentHeader(
        delegate: _HeaderDelegate<T, S, TController>(
          builder: (percent) => _Child<T, S, TController>(
              controller: controller, type: type, percent: percent),
          type: type,
        ),
        pinned: true,
        floating: true,
      );
    } else {
      return _Child<T, S, TController>(
          controller: controller, type: type, percent: 0);
    }
  }
}

class _HeaderDelegate<T, S extends BaseReadyListState<T>,
        TController extends ReadyListController<T, S>>
    extends SliverPersistentHeaderDelegate {
  final Widget Function(double percent) builder;
  final ResponsiveDataTableType type;

  _HeaderDelegate({
    required this.builder,
    required this.type,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var percent = (shrinkOffset / kTextTabBarHeight).clamp(0.0, 1.0);
    return builder(percent);
  }

  @override
  double get maxExtent => kToolbarHeight + 3;

  @override
  double get minExtent => kToolbarHeight + 3;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    if (oldDelegate is _HeaderDelegate<T, S, TController>) {
      return oldDelegate.type != type;
    }
    return false;
  }
}

class _Child<T, S extends BaseReadyListState<T>,
    TController extends ReadyListController<T, S>> extends StatelessWidget {
  final TController controller;
  final ResponsiveDataTableType type;
  final double percent;
  const _Child(
      {Key? key,
      required this.controller,
      required this.type,
      required this.percent})
      : super(key: key);
  bool get isList => type == ResponsiveDataTableType.list;

  @override
  Widget build(BuildContext context) {
    var options = context.dependOnInheritedWidgetOfExactType<
        ResponsiveDataTable<T, S, TController>>()!;
    var padding = type == ResponsiveDataTableType.list
        ? options.list?.padding
        : options.dataTable.padding;
    var color = (isList
            ? options.list?.headerColor?.call(percent)
            : options.dataTable.headerColor?.call(percent)) ??
        Theme.of(context).colorScheme.primary.withOpacity(percent);

    var p = padding?.resolve(Directionality.of(context)) ?? EdgeInsets.zero;
    return Container(
      padding: p.copyWith(bottom: 3, top: 0),
      height: kTextTabBarHeight,
      color: color,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (isList) ...[
            _SelectAllCheckBox<T, S, TController>(),
            _HeaderTitle<T, S, TController>(controller: controller),
            const Spacer(),
            _HeaderActions<T, S, TController>(
                type: type, controller: controller),
          ] else ...[
            _HeaderTitle<T, S, TController>(controller: controller),
            Expanded(
                child: _HeaderActions<T, S, TController>(
                    type: type, controller: controller)),
          ]
        ],
      ),
    );
  }
}
