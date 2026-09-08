import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foreign_emp_scam_checker/core/cubit/app_user_cubit.dart';
import 'package:foreign_emp_scam_checker/core/utils/show_toast.dart';
import 'package:foreign_emp_scam_checker/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:foreign_emp_scam_checker/features/checker/presentation/widgets/info_card.dart';
import 'package:foreign_emp_scam_checker/features/checker/presentation/widgets/recent_checks.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: AppBar(
        title: Text('JobGuard', style: Theme.of(context).textTheme.titleMedium),
        leading: Icon(Icons.shield),
        actions: [
          // Icon(Icons.notifications),
          GestureDetector(
            onTap: () {
              showToast('Logging out...');
              Future.delayed(
                Duration(seconds: 2),
                () {
                  if (!context.mounted) return;
                  context.read<AuthBloc>().add(AuthSignOut());
                },
              );
            },

            child: Icon(Icons.exit_to_app),
          ),
        ],
        actionsPadding: EdgeInsets.all(15.0),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocConsumer<AppUserCubit, AppUserState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),

                    Text(
                      'Good Afternoon ',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      'Protect your next career move.',
                      style: Theme.of(context).textTheme.bodyMedium!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),

                    const SizedBox(height: 10),

                    GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: 0.9,
                      children: [
                        InfoCard(
                          count: '128',
                          iconData: Icons.lock,
                          iconColor: Colors.blue,
                          labelText: 'Jobs Checked',
                        ),
                        InfoCard(
                          count: '42',
                          iconData: Icons.verified_outlined,
                          iconColor: Colors.green,
                          labelText: 'Agencies Verified',
                        ),
                        InfoCard(
                          count: '7',
                          iconData: Icons.error_outline,
                          iconColor: Colors.red,
                          labelText: 'High-Risk Found',
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: [
                            const Color.fromARGB(255, 115, 115, 230),
                            const Color.fromARGB(255, 103, 112, 116),
                          ], // gradient background
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              'Quick Scam Check',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),

                            Text(
                              'Paste a job post, message, or agency name and get an instant risk read.',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),

                            const SizedBox(height: 10),

                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(200, 50), // width, height
                                maximumSize: Size(double.infinity, 50),
                              ),

                              child: const Text('+ Start a Check'),
                            ),

                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 2,
                      children: [
                        Text('Recent checks', style: TextStyle(fontSize: 15.0)),
                        Text(
                          "See All",
                          style: TextStyle(
                            fontSize: 12.0,
                            color: const Color.fromARGB(255, 3, 66, 177),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    RecentChecks(
                      iconData: Icons.lock,
                      jobTitle: 'Backend Developer Intern',
                      date: 'Job · Aug 13',
                      jobRisk: 'Low Risk',
                      color: const Color.fromARGB(255, 16, 157, 89),
                    ),

                    RecentChecks(
                      iconData: Icons.lock,
                      jobTitle: 'Software Engineer',
                      date: 'Job · Aug 12',
                      jobRisk: 'High Risk',
                      color: Colors.red,
                    ),
                    RecentChecks(
                      iconData: Icons.list,
                      jobTitle: 'ABC Recruitment',
                      date: 'Agency · Aug 11',
                      jobRisk: 'Verified',
                      color: Colors.green,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory,
          splashColor: Colors.transparent,
        ),

        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.check), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: ''),
          ],
        ),
      ),
    );
  }
}
