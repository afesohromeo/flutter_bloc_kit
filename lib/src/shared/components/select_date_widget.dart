import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

class SelectDateWidget extends StatelessWidget {
  const SelectDateWidget({
    super.key,
    required this.textColor,
    this.fetchData,
  });
  final Color textColor;
  final VoidCallback? fetchData;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SharedBloc, SharedState>(
      builder: (context, state) {
        return Row(
          mainAxisSize: ResponsiveLayout.isMobile(context)
              ? MainAxisSize.max
              : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.calendar_month_outlined,
              color: AppColors.blue2,
              size: 20,
            ),
            const Gap.horizontal(width: 4),
            Flexible(
              fit: FlexFit.loose,
              child: Text(
                  '${DateFormat('d MMM yyyy', 'fr_FR').format(state.dateFrom ?? DateTime.now())} au ${DateFormat('d MMM yyyy', 'fr_FR').format(state.dateTo ?? DateTime.now())}',
                  // textAlign: TextAlign.center,
                  softWrap: true,
                  style: AppTheme.lightTextTheme.displayMedium!
                      .copyWith(fontSize: 14, color: textColor)),
            ),
            const Gap.horizontal(width: 08),
            IconButton(
              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
              iconSize: 20,
              padding: EdgeInsets.zero,
              color: textColor,
              onPressed: () {
                _selectStartDate(context, state);
              },
              icon: const Icon(
                Icons.edit_rounded,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _selectStartDate(BuildContext context, SharedState state) async {
    if (!context.mounted) {
      return; // Avoid operations if the context is no longer valid
    }

    final DateTime? dateFrom = await showDatePicker(
        context: context,
        initialDate: state.dateFrom,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
        helpText: 'Période du');

    if (dateFrom != null) {
      if (context.mounted) {
        _selectEndDate(context, dateFrom, state);
      }
    }
  }

  Future<void> _selectEndDate(
      BuildContext context, DateTime dateFrom, SharedState state) async {
    final DateTime? dateTo = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: dateFrom,
        lastDate: DateTime(2101),
        helpText: 'Période au');

    if (dateTo != null) {
      if (dateFrom != state.dateFrom || dateTo != state.dateTo) {
        if (context.mounted) {
          log('new fetch ${fetchData == null}');
          context.read<SharedBloc>().add(
              SharedEvent.datesUpdated(dateFrom: dateFrom, dateTo: dateTo));
        }
      }
    }
  }
}
