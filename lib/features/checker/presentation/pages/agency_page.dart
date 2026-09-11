import 'package:flutter/material.dart';
import 'package:foreign_emp_scam_checker/features/auth/buttons/custom_scan_button.dart';
import 'package:foreign_emp_scam_checker/features/checker/presentation/widgets/cards/agency_details.dart';
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

  List<Map<String, dynamic>> agenciesList = [
    {
      "name": "ABC company",
      "license no.": "989387383",
    },
    {
      "name": "XYZ company",
      "license no.": "980288983",
    },
    {
      "name": "OIH company",
      "license no.": "989318983",
    },
    {
      "name": "EWA company",
      "license no.": "987288983",
    },
    {
      "name": "IFO company",
      "license no.": "970388983",
    },
  ];
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownMenu(
                controller: _agencyController,
                label: Text('Select a company'),

                helperText: 'Please choose a company you\'d like to check',
                enableSearch: true,
                width: double.infinity,
                dropdownMenuEntries: <DropdownMenuEntry<Map<String, dynamic>>>[
                  for (int i = 0; i < agenciesList.length; i++)
                    DropdownMenuEntry(
                      style: ButtonStyle(),
                      value: agenciesList[i],
                      label: agenciesList[i]['name'],
                    ),
                ],
              ),

              const SizedBox(height: 20),

              CustomScanButton(
                icon: Icons.check_circle_outline_rounded,
                label: 'Start Scan',
              ),

              const SizedBox(height: 20),

              // Status row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Company name',
                    style: TextStyle(fontSize: 17),
                  ),

                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(105, 249, 151, 0.2),
                      border: BoxBorder.all(
                        color: Color.fromRGBO(81, 243, 133, 0.4),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.verified_outlined,
                          size: 20,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Verified Agency',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Reports Card
              AgencyDetails(
                children: [
                  ReportRow(label: 'License no.', value: '1011'),
                  const Divider(),
                  ReportRow(label: 'Location', value: 'address_location'),
                  const Divider(),
                  ReportRow(label: 'Status', value: 'Active'),
                  const Divider(),
                  ReportRow(label: 'Contact Person', value: 'Person'),
                  const Divider(),
                  ReportRow(label: 'Phone no.', value: '9743...'),
                  const Divider(),
                  ReportRow(label: 'Website', value: 'site_web'),
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
