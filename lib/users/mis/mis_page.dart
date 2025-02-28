import 'package:css_website_access/pages/audit-logs/audit_logs.dart';
import 'package:css_website_access/pages/dashboard/dashboard.dart';
import 'package:css_website_access/pages/data-management/data_management.dart';
import 'package:css_website_access/pages/data-responses/data_responses.dart';
import 'package:css_website_access/pages/display/display.dart';
import 'package:css_website_access/pages/entity-management/entity_management.dart';
import 'package:css_website_access/pages/qr-generation/qr_generation.dart';
import 'package:css_website_access/pages/reports/ncar_page.dart';
import 'package:css_website_access/pages/reports/reports_page.dart';
import 'package:css_website_access/pages/reports/results_page.dart';
import 'package:css_website_access/pages/survey/survey.dart';
import 'package:css_website_access/pages/edit-survey/survey_mis.dart';
import 'package:css_website_access/pages/template-management/template_management.dart';
import 'package:css_website_access/pages/user-management/user_management.dart';
import 'package:css_website_access/widgets/custom_listile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MisPage extends StatefulWidget {
  const MisPage({super.key});

  @override
  State<MisPage> createState() => _MisPageState();
}

class _MisPageState extends State<MisPage> {
  bool _showSubMenu = false;
  Widget _currentPage = Dashboard();
  String _active = "Dashboard";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE6E7EC),
      body: Row(
        children: [
          Container(
            width: 280,
            decoration: BoxDecoration(
              color: Color(0xFFF1F7F9),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF1E1E1E).withValues(alpha: 0.4),
                  blurRadius: 5,
                  spreadRadius: 2,
                  offset: Offset(2, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: SvgPicture.asset(
                      'svg/Logo.svg',
                      height: 100,
                      width: 50,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomListTile(
                    textStyle: TextStyle(
                        fontWeight: _active == "Dashboard"
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: _active == "Dashboard"
                            ? Color(0xFF064089)
                            : Color(0xFF48494A)),
                    onTapCallback: () {
                      setState(() {
                        _active = "Dashboard";
                        _currentPage = Dashboard();
                      });
                    },
                    text: 'Dashboard',
                    svgPath: 'svg/icons/dashboard.svg',
                    color: _active == "Dashboard"
                        ? Color(0xFF064089)
                        : Color(0xFF48494A),
                  ),
                  CustomListTile(
                    textStyle: TextStyle(
                        fontWeight: _active == "Survey"
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: _active == "Survey"
                            ? Color(0xFF064089)
                            : Color(0xFF48494A)),
                    onTapCallback: () {
                      setState(() {
                        _active = "Survey";
                        _currentPage = Survey();
                      });
                    },
                    text: 'Survey',
                    svgPath: 'svg/icons/survey.svg',
                    color: _active == "Survey"
                        ? Color(0xFF064089)
                        : Color(0xFF48494A),
                  ),
                  CustomListTile(
                    textStyle: TextStyle(
                        fontWeight: _active == "Data Responses"
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: _active == "Data Responses"
                            ? Color(0xFF064089)
                            : Color(0xFF48494A)),
                    onTapCallback: () {
                      setState(() {
                        _active = "Data Responses";
                        _currentPage = DataResponses();
                      });
                    },
                    text: 'Data Responses',
                    svgPath: 'svg/icons/page-edit.svg',
                    color: _active == "Data Responses"
                        ? Color(0xFF064089)
                        : Color(0xFF48494A),
                  ),
                  CustomListTile(
                    textStyle: TextStyle(
                        fontWeight: _active == "Reports"
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: _active == "Reports"
                            ? Color(0xFF064089)
                            : Color(0xFF48494A)),
                    onTapCallback: () {
                      setState(() {
                        _showSubMenu = !_showSubMenu;
                        _active = "Reports";
                      });
                    },
                    text: 'Reports',
                    svgPath: 'svg/icons/file-earmark-bar-graph.svg',
                    color: _active.startsWith("Reports")
                        ? Color(0xFF064089)
                        : Color(0xFF48494A),
                  ),
                  if (_showSubMenu) ...[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text('Results',
                                style: TextStyle(
                                  color: _active == "Reports - Results"
                                      ? Color(0xFF064089)
                                      : Color(0xFF48494A),
                                )),
                            onTap: () {
                              setState(() {
                                _active = "Reports - Results";
                                _currentPage = ResultsPage();
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 30,
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text('Reports',
                                style: TextStyle(
                                  color: _active == "Reports - Reports"
                                      ? Color(0xFF064089)
                                      : Color(0xFF48494A),
                                )),
                            onTap: () {
                              setState(() {
                                _active = "Reports - Reports";
                                _currentPage = ReportsPage();
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 30,
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              'NCAR',
                              style: TextStyle(
                                color: _active == "Reports - NCAR"
                                    ? Color(0xFF064089)
                                    : Color(0xFF48494A),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                _active = "Reports - NCAR";
                                _currentPage = NcarPage();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                  SizedBox(
                    height: 10,
                  ),
                  CustomListTile(
                    textStyle: TextStyle(
                        fontWeight: _active == "QR Generation"
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: _active == "QR Generation"
                            ? Color(0xFF064089)
                            : Color(0xFF48494A)),
                    onTapCallback: () {
                      setState(() {
                        _active = "QR Generation";
                        _currentPage = QrGeneration();
                      });
                    },
                    text: 'QR Generation',
                    svgPath: 'svg/icons/scan-qr-code.svg',
                    color: _active == "QR Generation"
                        ? Color(0xFF064089)
                        : Color(0xFF48494A),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'SETTINGS',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF48494A),
                      ),
                    ),
                  ),
                  CustomListTile(
                    textStyle: TextStyle(
                        fontWeight: _active == "Edit Survey"
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: _active == "Edit Survey"
                            ? Color(0xFF064089)
                            : Color(0xFF48494A)),
                    onTapCallback: () {
                      setState(() {
                        _active = "Edit Survey";
                        _currentPage = SurveyMis();
                      });
                    },
                    text: 'Edit Survey',
                    svgPath: 'svg/icons/edit.svg',
                    color: _active == "Edit Survey"
                        ? Color(0xFF064089)
                        : Color(0xFF48494A),
                  ),
                  CustomListTile(
                    textStyle: TextStyle(
                        fontWeight: _active == "Template Management"
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: _active == "Template Management"
                            ? Color(0xFF064089)
                            : Color(0xFF48494A)),
                    onTapCallback: () {
                      setState(() {
                        _active = "Template Management";
                        _currentPage = TemplateManagement();
                      });
                    },
                    text: 'Template Management',
                    svgPath: 'svg/icons/template-management.svg',
                    color: _active == "Template Management"
                        ? Color(0xFF064089)
                        : Color(0xFF48494A),
                  ),
                  CustomListTile(
                    textStyle: TextStyle(
                        fontWeight: _active == "User Management"
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: _active == "User Management"
                            ? Color(0xFF064089)
                            : Color(0xFF48494A)),
                    onTapCallback: () {
                      setState(() {
                        _active = "User Management";
                        _currentPage = UserManagement();
                      });
                    },
                    text: 'User Management',
                    svgPath: 'svg/icons/user-management.svg',
                    color: _active == "User Management"
                        ? Color(0xFF064089)
                        : Color(0xFF48494A),
                  ),
                  CustomListTile(
                    textStyle: TextStyle(
                        fontWeight: _active == "Entity Management"
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: _active == "Entity Management"
                            ? Color(0xFF064089)
                            : Color(0xFF48494A)),
                    onTapCallback: () {
                      setState(() {
                        _active = "Entity Management";
                        _currentPage = EntityManagement();
                      });
                    },
                    text: 'Entity Management',
                    svgPath: 'svg/icons/entity-management.svg',
                    color: _active == "Entity Management"
                        ? Color(0xFF064089)
                        : Color(0xFF48494A),
                  ),
                  CustomListTile(
                    textStyle: TextStyle(
                        fontWeight: _active == "Data Management"
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: _active == "Data Management"
                            ? Color(0xFF064089)
                            : Color(0xFF48494A)),
                    onTapCallback: () {
                      setState(() {
                        _active = "Data Management";
                        _currentPage = DataManagement();
                      });
                    },
                    text: "Data Management",
                    svgPath: 'svg/icons/data-management.svg',
                    color: _active == "Data Management"
                        ? Color(0xFF064089)
                        : Color(0xFF48494A),
                  ),
                  CustomListTile(
                    textStyle: TextStyle(
                        fontWeight: _active == "Audit Logs"
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: _active == "Audit Logs"
                            ? Color(0xFF064089)
                            : Color(0xFF48494A)),
                    onTapCallback: () {
                      setState(() {
                        _active = "Audit Logs";
                        _currentPage = AuditLogs();
                      });
                    },
                    text: 'Audit Logs',
                    svgPath: 'svg/icons/audit-log.svg',
                    color: _active == "Audit Logs"
                        ? Color(0xFF064089)
                        : Color(0xFF48494A),
                  ),
                  CustomListTile(
                    textStyle: TextStyle(
                        fontWeight: _active == "Displays"
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: _active == "Displays"
                            ? Color(0xFF064089)
                            : Color(0xFF48494A)),
                    onTapCallback: () {
                      setState(() {
                        _active = "Displays";
                        _currentPage = DisplayPage();
                      });
                    },
                    text: 'Displays',
                    svgPath: 'svg/icons/display.svg',
                    color: _active == "Displays"
                        ? Color(0xFF064089)
                        : Color(0xFF48494A),
                  ),
                  const Spacer(),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.logout, color: Color(0xFF064089)),
                      label: const Text(
                        'Logout',
                        style: TextStyle(color: Color(0xFF064089)),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(
                            color: Color(0xFF064089), width: 2.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: _currentPage,
          ),
        ],
      ),
    );
  }
}
