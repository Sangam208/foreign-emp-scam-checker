import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foreign_emp_scam_checker/core/common/widgets/loader.dart';
import 'package:foreign_emp_scam_checker/core/utils/show_toast.dart';
import 'package:foreign_emp_scam_checker/features/checker/domain/entities/agency.dart';
import 'package:foreign_emp_scam_checker/features/checker/presentation/bloc/agency_bloc.dart';
import 'package:foreign_emp_scam_checker/features/checker/presentation/widgets/buttons/custom_scan_button.dart';
import 'package:foreign_emp_scam_checker/features/checker/presentation/widgets/cards/agency_details.dart';
import 'package:foreign_emp_scam_checker/features/checker/presentation/widgets/fields/agency_field.dart';
import 'package:foreign_emp_scam_checker/features/checker/presentation/widgets/navbar/custom_bottom_nav_bar.dart';
import 'package:foreign_emp_scam_checker/features/checker/presentation/widgets/rows/report_row.dart';

class AgencyPage extends StatefulWidget {
  const AgencyPage({super.key});

  @override
  State<AgencyPage> createState() => _AgencyPageState();
}

class _AgencyPageState extends State<AgencyPage> {
  final TextEditingController _agencyController = TextEditingController();
  int _selectedIndex = 0;
  void _onItemTapped(int index) => setState(() {
    _selectedIndex = index;
  });

  List<Agency> agencies = [];

  List<DropdownMenuEntry<Agency>> entries = [];

  bool _isStartScan = false;

  void _checkAgencySelection() {
    setState(() {
      if (_agencyController.text.trim().isEmpty) {
        showToast('Please choose an agency');
      }
      _isStartScan = true;
    });
  }

  @override
  void initState() {
    context.read<AgencyBloc>().add(AgencyLoadData());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _agencyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Verify an Agency',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<AgencyBloc, AgencyState>(
            listener: (context, state) {
              if (state is AgencyFailure) showToast(state.message);
              if (state is AgencySuccess) {
                entries = [
                  for (final agency in state.agenciesList)
                    DropdownMenuEntry(
                      value: agency,
                      label: agency.agencyName,
                    ),
                ];
              }
            },
            builder: (context, state) {
              agencies = state is AgencySuccess ? state.agenciesList : [];

              final selectedAgency = agencies
                  .where(
                    (agency) =>
                        agency.agencyName == _agencyController.text.trim(),
                  )
                  .firstOrNull;

              bool showDetails =
                  state is AgencySuccess &&
                  _isStartScan &&
                  _agencyController.text.trim().isNotEmpty;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // DropdownMenu displaying list of agencies
                  AgencyField(
                    agencyController: _agencyController,
                    agencies: agencies,
                    entries: entries,
                  ),

                  const SizedBox(height: 20),

                  CustomScanButton(
                    icon: Icons.check_circle_outline_rounded,
                    label: 'Start Scan',
                    onPressed: _checkAgencySelection,
                  ),

                  if (showDetails)
                    state is AgencyLoading
                        ? const Loader()
                        : selectedAgency != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),

                              // Status row
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    child: Text(
                                      _agencyController.text.trim(),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),

                                  const SizedBox(width: 5),

                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(
                                          105,
                                          249,
                                          151,
                                          0.2,
                                        ),
                                        border: BoxBorder.all(
                                          color: Color.fromRGBO(
                                            81,
                                            243,
                                            133,
                                            0.4,
                                          ),
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                      ),
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.verified_outlined,
                                            size: 20,
                                            color: Colors.green,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            'Verified',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 10),

                              // Reports Card
                              AgencyDetails(
                                children: [
                                  ReportRow(
                                    label: 'License no.',
                                    value: selectedAgency.licenseNo,
                                  ),
                                  const Divider(),
                                  ReportRow(
                                    label: 'Location',
                                    value: selectedAgency.address,
                                  ),
                                  const Divider(),
                                  ReportRow(
                                    label: 'Status',
                                    value: selectedAgency.status,
                                  ),
                                  const Divider(),
                                  ReportRow(
                                    label: 'Contact Person',
                                    value: selectedAgency.contactPerson,
                                  ),
                                  const Divider(),
                                  ReportRow(
                                    label: 'Phone no./Fax',
                                    value: selectedAgency.phoneFax,
                                  ),
                                  const Divider(),
                                  ReportRow(
                                    label: 'Email/Website',
                                    value: selectedAgency.emailOrWebsite,
                                  ),
                                ],
                              ),

                              // const SizedBox(height: 5),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SelectableText(
                                  'Source: DoFE-compiled registry • Last verified as of July 6, 2026',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Center(
                            child: const Text(
                              'No data available. Please try again later.',
                            ),
                          ),
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
