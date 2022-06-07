import 'package:flutter/material.dart';
import 'package:sertinary/constants/color_constants.dart';

class DayOfTheWeekButton extends StatefulWidget {
  final Color selectedColor;
  final Color unselectedColor;
  final bool selected;
  final String day;
  final void Function()? onPressed;

  const DayOfTheWeekButton({
    Key? key,
    required this.selectedColor,
    required this.unselectedColor,
    required this.selected,
    required this.day,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<DayOfTheWeekButton> createState() => _DayOfTheWeekButtonState();
}

class _DayOfTheWeekButtonState extends State<DayOfTheWeekButton> {
  late Color _selectedColor;
  late Color _unselectedColor;
  late bool _selected;
  late String _day;
  late void Function()? _onPressed;

  @override
  Widget build(BuildContext context) {
    _selectedColor = widget.selectedColor;
    _unselectedColor = widget.unselectedColor;
    _selected = widget.selected;
    _day = widget.day;
    _onPressed = widget.onPressed;
    return SizedBox(
      width: 51,
      child: ElevatedButton(
        onPressed: () {
          _onPressed;
        },
        style: ElevatedButton.styleFrom(
          primary: _selected ? _selectedColor : _unselectedColor,
          padding: const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          textStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: ColorConstants.monoAA,
          ),
        ),
        child: Text(
          _day,
        ),
      ),
    );
  }
}
