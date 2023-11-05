import 'package:flutter/material.dart';
import 'package:ready/ready.dart';

import 'controller.dart';
import 'pickers.dart';
import 'sheet.dart';

class MultiField<T, S extends BaseReadyListState<T>,
    TController extends ReadyPickerController<T, S>> extends StatelessWidget {
  const MultiField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var picker = ReadyMultiPicker.of<T, S, TController>(context)!;
    return FormField<List<T>>(
        key: key,
        initialValue: picker.initialValue ?? [],
        validator: picker.validator,
        onSaved: picker.onSaved,
        autovalidateMode: picker.autovalidateMode,
        builder: (FormFieldState<List<T>> field) {
          return _ReadyMultiPicker<T, S, TController>(
            field: field,
            picker: picker,
          );
        });
  }
}

class _ReadyMultiPicker<T, S extends BaseReadyListState<T>,
    TController extends ReadyPickerController<T, S>> extends StatefulWidget {
  final FormFieldState<List<T>> field;
  final ReadyMultiPicker<T, S, TController> picker;

  const _ReadyMultiPicker({
    Key? key,
    required this.field,
    required this.picker,
  }) : super(key: key);

  @override
  __ReadyMultiPickerState<T, S, TController> createState() =>
      __ReadyMultiPickerState<T, S, TController>();
}

class __ReadyMultiPickerState<T, S extends BaseReadyListState<T>,
        TController extends ReadyPickerController<T, S>>
    extends State<_ReadyMultiPicker<T, S, TController>>
    with AutomaticKeepAliveClientMixin {
  FocusNode get _effectiveFocusNode =>
      widget.picker.focusNode ?? (_focusNode ??= FocusNode());
  FocusNode? _focusNode;
  bool _hasPrimaryFocus = false;

  late FocusAttachment attachment;
  @override
  bool get wantKeepAlive => true;

  bool sheetOpened = false;

  void _handleFocusChanged() {
    if (_hasPrimaryFocus != _effectiveFocusNode.hasPrimaryFocus) {
      setState(() {
        _hasPrimaryFocus = _effectiveFocusNode.hasPrimaryFocus;
      });
      if (_hasPrimaryFocus && !sheetOpened) {
        _effectiveFocusNode.unfocus();
        showSheet();
      }
    }
  }

  @override
  void didChangeDependencies() {
    attachment = _effectiveFocusNode.attach(context);
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(
      covariant _ReadyMultiPicker<T, S, TController> oldWidget) {
    _effectiveFocusNode.removeListener(_handleFocusChanged);
    _effectiveFocusNode.addListener(_handleFocusChanged);
    _effectiveFocusNode.canRequestFocus = widget.picker.enabled;
    _hasPrimaryFocus = _effectiveFocusNode.hasPrimaryFocus;
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    _effectiveFocusNode.addListener(_handleFocusChanged);
    _effectiveFocusNode.canRequestFocus = widget.picker.enabled;
    super.initState();
  }

  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_handleFocusChanged);
    _focusNode?.dispose();
    attachment.detach();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    attachment.reparent();
    super.build(context);
    var options = ReadyMultiPicker.of<T, S, TController>(context)!;

    final effectiveDecoration = options.decoration
        .applyDefaults(Theme.of(context).inputDecorationTheme);
    final style =
        Theme.of(context).textTheme.titleMedium?.merge(options.textStyle) ??
            options.textStyle;
    var value = widget.field.value ?? [];
    return GestureDetector(
      onTap: () {
        _effectiveFocusNode.requestFocus();
      },
      behavior: HitTestBehavior.opaque,
      child: Focus(
        focusNode: _effectiveFocusNode,
        child: Semantics(
          button: true,
          child: options.builder != null
              ? options.builder!(widget.field)
              : InputDecorator(
                  isFocused: _effectiveFocusNode.hasFocus,
                  decoration: effectiveDecoration.copyWith(
                    errorText: widget.field.errorText,
                    enabled: options.enabled,
                    suffixIcon: effectiveDecoration.suffixIcon ??
                        (widget.field.value == null
                            ? null
                            : IconButton(
                                icon: Icon(
                                  Icons.delete_rounded,
                                  color: Theme.of(context).colorScheme.error,
                                ),
                                onPressed: () {
                                  widget.field.didChange(null);
                                  options.onChanged?.call(null);
                                },
                              )),
                  ),
                  isEmpty: value.isEmpty,
                  textAlign: options.textAlign,
                  child: value.isEmpty
                      ? const Text('')
                      : Text(
                          value
                              .map((e) =>
                                  options.controller.getDisplay(context, e))
                              .join(','),
                          style: style,
                          textAlign: options.textAlign,
                          maxLines: options.maxLines,
                        ),
                ),
        ),
      ),
    );
  }

  Widget getSheet(ReadyMultiPicker<T, S, TController> options) {
    return SelectorSheet<T, S, TController>(
      controller: options.controller,
      allowMultiple: true,
      buildItem: options.buildItem,
      textStyle: options.itemTextStyle,
      activeColor: options.activeColor,
      inActiveColor: options.inActiveColor,
      selectedItems: widget.field.value ?? [],
    );
  }

  Future showSheet() {
    var options = ReadyMultiPicker.of<T, S, TController>(context)!;
    Future future;
    if (options.showItems != null) {
      future = options.showItems!(
        widget.field.context,
        getSheet(options),
      );
    } else {
      future = showModalBottomSheet(
        context: widget.field.context,
        isScrollControlled: true,
        clipBehavior: Clip.antiAlias,
        builder: (ctx) => getSheet(options),
      );
    }
    return future.then((value) {
      if (value is List<T>) {
        widget.field.didChange(value);
        options.onChanged?.call(value);
      }
    });
  }
}
