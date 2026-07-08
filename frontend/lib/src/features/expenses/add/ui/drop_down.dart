import 'package:budget_manager/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GenericDropDown<T> extends ConsumerStatefulWidget {
  final AsyncValue<List<T>> list;
  final T? selected;
  final void Function(T?) onChanged;
  final String Function(T) itemLabel;
  final VoidCallback? onAddRequest;
  final String? addButtonLabel;
  final String? hintText;
  final Widget? leadingIcon;
  final Widget Function(T)? leadingIconBuilder;
  final void Function(T)? onDelete;

  const GenericDropDown({
    super.key,
    required this.list,
    this.selected,
    required this.onChanged,
    required this.itemLabel,
    this.onAddRequest,
    this.addButtonLabel,
    this.hintText,
    this.leadingIcon,
    this.onDelete,
    this.leadingIconBuilder,
  });

  @override
  ConsumerState<GenericDropDown<T>> createState() => _GenericDropDownState<T>();
}

class _GenericDropDownState<T> extends ConsumerState<GenericDropDown<T>> {
  final TextEditingController _dropdownController = TextEditingController();

  @override
  void dispose() {
    _dropdownController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return FormField<T>(
      initialValue: widget.selected,
      validator: (_) => widget.selected == null ? s.select_option : null,
      builder: (FormFieldState<T> state) {
        return DropdownMenu<T?>(
          controller: _dropdownController,
          initialSelection: widget.selected,
          hintText: widget.hintText ?? s.select_option,
          onSelected: (T? value) {
            if (widget.onAddRequest != null && value == null) {
              widget.onAddRequest!();
              _dropdownController.clear();
              state.didChange(null);
            } else {
              state.didChange(value);
              widget.onChanged(value);
            }
          },
          errorText: state.errorText,
          expandedInsets: EdgeInsets.zero,
          dropdownMenuEntries: widget.list.when(
            data: (items) => [
              if (widget.onAddRequest != null)
                DropdownMenuEntry<T?>(
                  value: null,
                  // label: widget.addButtonLabel ?? s.add,
                  label: '',
                  leadingIcon: const Icon(Icons.add, size: 20),
                ),
              ...items.map<DropdownMenuEntry<T?>>((T item) {
                return DropdownMenuEntry<T?>(
                  value: item,
                  label: widget.itemLabel(item),
                  leadingIcon:
                      widget.leadingIconBuilder?.call(item) ??
                      widget.leadingIcon,
                  trailingIcon: GestureDetector(
                    onTap: () {
                      widget.onDelete?.call(item);
                      _dropdownController.clear();
                    },
                    child: const Icon(Icons.delete),
                  ),
                );
              }),
            ],
            error: (_, _) => const [],
            loading: () => const [],
          ),
        );
      },
    );
  }
}
