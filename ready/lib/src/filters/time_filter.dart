part of 'filters.dart';

/// time filter
class TimeFilter extends StatelessWidget
    with DecoratedDataTableFilter<TimeOfDay?> {
  @override
  final ValueChanged<TimeOfDay?> onChange;
  final String? display;
  @override
  final TimeOfDay? value;
  @override
  final InputDecoration decoration;
  const TimeFilter({
    Key? key,
    required this.onChange,
    this.value,
    this.display,
    this.decoration =
        const _DefaultInputDecoration(Icon(Icons.calendar_month_rounded)),
  }) : super(key: key);
  @override
  String hintText(ReadyListLocalizations tr) {
    return display ?? tr.time;
  }

  @override
  Widget build(BuildContext context) {
    final effectiveDecoration = _effectiveDecoration(context);
    var val = value;
    return buildTab(
        context,
        IntrinsicWidth(
          child: InputDecorator(
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.start,
            decoration: effectiveDecoration,
            isEmpty: val == null,
            child: Text(val?.format(context) ?? ""),
          ),
        ));
  }

  Widget buildTab(BuildContext context, Widget child) {
    return InkWell(
      onTap: () {
        buildShowTimePicker(context).then(
          (value) {
            if (value != null) onChange(value);
          },
        );
      },
      child: child,
    );
  }

  Future<TimeOfDay?> buildShowTimePicker(BuildContext context) {
    var val = value;
    return showTimePicker(
      context: context,
      initialTime: val ?? TimeOfDay.fromDateTime(DateTime.now()),
    );
  }
}
