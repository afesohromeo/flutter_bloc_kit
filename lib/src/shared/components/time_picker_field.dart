import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';
import 'package:flutter/material.dart';

class TimePickerField extends StatefulWidget {
  const TimePickerField({
    super.key,
    required this.labelText,
    required this.value,
    required this.onChanged,
    this.validator,
    this.radius = 10,
    this.use24HourFormat = true,
  });

  final String labelText;
  final TimeOfDay? value;
  final ValueChanged<TimeOfDay?> onChanged;
  final String? Function(String?)? validator;
  final double radius;
  final bool use24HourFormat;

  @override
  State<TimePickerField> createState() => _TimePickerFieldState();
}

class _TimePickerFieldState extends State<TimePickerField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _syncText();
  }

  @override
  void didUpdateWidget(covariant TimePickerField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _syncText();
    }
  }

  void _syncText() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _controller.text = widget.value == null ? '' : _formatTime(widget.value!);
    });
  }

  String _formatTime(TimeOfDay time) {
    if (widget.use24HourFormat) {
      final hour = time.hour.toString().padLeft(2, '0');
      final minute = time.minute.toString().padLeft(2, '0');
      return '$hour:$minute';
    } else {
      final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
      final minute = time.minute.toString().padLeft(2, '0');
      final period = time.period == DayPeriod.am ? 'AM' : 'PM';
      return '$hour:$minute $period';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<TimeOfDay?> _selectTime(
    BuildContext context,
    TimeOfDay? initialTime,
  ) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(alwaysUse24HourFormat: widget.use24HourFormat),
          child: child!,
        );
      },
    );
    if (picked != null) {
      return picked;
    } else {
      return initialTime;
    }
  }

  void _clearField() {
    _controller.clear();
    widget.onChanged(null);
  }

  @override
  Widget build(BuildContext context) {
    final hasFilled = widget.value != null;

    return InputField(
      readOnly: true,
      onTap: () async {
        final time = await _selectTime(context, widget.value);

        widget.onChanged(time);
      },
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
          : const Icon(Icons.access_time, size: 20),
    );
  }
}
