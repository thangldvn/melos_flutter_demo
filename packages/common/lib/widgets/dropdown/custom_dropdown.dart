import 'package:flutter/material.dart';

enum DropDownType {
  formField,
  popUpMenu,
  button,
}

abstract class DropDownCustom<T> extends StatelessWidget {
  Color get primaryColor;

  String getItem(item);

  const DropDownCustom(
      {super.key,
      this.dropDownType = DropDownType.button,
      required this.items,
      this.customWidgets,
      this.initialValue,
      this.hint,
      this.onChanged,
      this.isExpanded = false,
      this.icon,
      this.isCleared = false,
      this.showUnderline = true,
      this.colorUnderline = Colors.transparent})
      : assert(items is! Widget),
        assert((customWidgets != null)
            ? items?.length == customWidgets.length
            : (customWidgets == null));
  final DropDownType dropDownType;
  final List<T>? items;

  /// If needs to render custom widgets for dropdown items must provide values
  /// for customWidgets
  /// Also the customWidgets length have to be equals to items
  final List<Widget>? customWidgets;
  final T? initialValue;
  final Widget? hint;
  final Function(T?)? onChanged;
  final bool isExpanded;
  final Widget? icon;

  /// If need to clear dropdown currently selected value
  final bool isCleared;

  /// You can choose between show an underline at bottom or not
  final bool showUnderline;
  final Color colorUnderline;

  @override
  Widget build(BuildContext context) {
    Widget dropdown;
    switch (dropDownType) {
      case DropDownType.formField:
        dropdown = const SizedBox();
        break;
      case DropDownType.popUpMenu:
        dropdown = const SizedBox();
        break;
      // case DropDownType.Button: // Empty statement
      default:
        dropdown = DropdownButton<T>(
          isExpanded: isExpanded,
          onChanged: (T? value) {
            //setState(() => selectedValue = value);
            onChanged?.call(value);
          },
          underline: Container(
            height: 1,
            color: colorUnderline,
          ),
          value: initialValue,
          items: items
              ?.map<DropdownMenuItem<T>>((item) => buildDropDownItem(item))
              .toList(),
          hint: hint,
          icon: icon ??
              Icon(
                Icons.expand_more,
                color: primaryColor,
              ),
        );
    }

    // Wrapping Dropdown in DropdownButtonHideUnderline removes the underline
    return showUnderline
        ? dropdown
        : DropdownButtonHideUnderline(child: dropdown);
  }

  DropdownMenuItem<T> buildDropDownItem(T item) => DropdownMenuItem<T>(
        value: item,
        child: (customWidgets != null)
            ? customWidgets![items?.indexOf(item) ?? 0]
            : Text(getItem(item)),
      );
}
