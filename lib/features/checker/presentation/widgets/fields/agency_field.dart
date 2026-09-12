import 'package:flutter/material.dart';
import 'package:foreign_emp_scam_checker/features/checker/domain/entities/agency.dart';

class AgencyField extends StatelessWidget {
  final TextEditingController agencyController;
  final List<Agency> agencies;
  final List<DropdownMenuEntry<Agency>> entries;
  const AgencyField({
    super.key,
    required this.agencyController,
    required this.agencies,
    required this.entries,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      controller: agencyController,
      menuHeight: 300,
      label: Text('Select an agency'),
      helperText: agencyController.text.trim().isEmpty
          ? 'Please choose an agency you\'d like to check'
          : null,
      enableSearch: false,
      width: double.infinity,
      dropdownMenuEntries: entries,
    );
  }
}
