import 'package:flutter/material.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

class DatePickerField extends StatefulWidget {
  const DatePickerField({
    super.key,
    required this.labelText,
    required this.value,
    required this.onChanged,
    this.validator,
    this.radius = 10,
    this.format,
    this.withTime = false,
  });

  final String labelText;
  final DateTime? value;
  final ValueChanged<DateTime?> onChanged;
  final String? Function(String?)? validator;
  final double radius;
  final String? format;
  final bool withTime;

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _syncText();
  }

  @override
  void didUpdateWidget(covariant DatePickerField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _syncText();
    }
  }

  void _syncText() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _controller.text = widget.value == null
          ? ''
          : formatDate(widget.value!, withTime: widget.withTime);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<DateTime?> _selectDateTime(
      BuildContext context, DateTime? initialDate) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (pickedDate == null) return initialDate;

    if (!widget.withTime) return pickedDate;

    if (!context.mounted) return pickedDate;
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
          hour: initialDate?.hour ?? 0, minute: initialDate?.minute ?? 0),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            alwaysUse24HourFormat: true,
          ),
          child: child!,
        );
      },
    );

    if (pickedTime == null) return initialDate;
    FocusManager.instance.primaryFocus?.unfocus();

    return DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );
  }

  void _clearField() {
    _controller.clear();
    widget.onChanged(null);
  }

  @override
  Widget build(BuildContext context) {
    final hasFilled = widget.value != null;

    return InputField(
      onTap: () async {
        final result = await _selectDateTime(context, widget.value);
        widget.onChanged(result);
      },
      readOnly: true,
      visualDensity: VisualDensity(vertical: -2.8),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      labelText: widget.labelText,
      controller: _controller,
      validator: widget.validator,
      keyboardType: TextInputType.text,
      radius: widget.radius,
      enableSuggestions: true,
      obscureText: false,
      padding: EdgeInsets.zero,
      labelColor: customColors.black1.withValues(alpha: .8),
      suffixIcon: hasFilled
          ? GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: _clearField,
              child: Icon(
                Icons.close,
                size: 20,
                color: customColors.black1.withValues(alpha: .8),
              ),
            )
          : Icon(
              widget.withTime ? Icons.access_time : Icons.calendar_today,
              size: 20,
            ),
    );
  }
}
