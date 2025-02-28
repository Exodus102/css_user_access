import 'package:css_website_access/pages/edit-survey/survey_section.dart';
import 'package:flutter/material.dart';
import 'package:css_website_access/pages/edit-survey/show_button.dart';
import 'package:css_website_access/widgets/custom_button.dart';
import 'package:css_website_access/widgets/custom_header.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SurveyMis extends StatefulWidget {
  const SurveyMis({super.key});

  @override
  State<SurveyMis> createState() => _SurveyMisState();
}

class _SurveyMisState extends State<SurveyMis> {
  List<int> sectionNumbers = [];
  Map<String, List<Map<String, dynamic>>> sections = {};
  List<Map<String, dynamic>> deletedQuestions = [];

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  void _addSection() {
    setState(() {
      int newSectionNumber = sectionNumbers.length + 1;
      sectionNumbers.add(newSectionNumber);
      sections['Section $newSectionNumber'] = [];
    });
  }

  void _updateSection(
      String sectionKey, List<Map<String, dynamic>> updatedQuestions) {
    setState(() {
      List<Map<String, dynamic>> oldQuestions = sections[sectionKey] ?? [];
      List<Map<String, dynamic>> mergedQuestions =
          updatedQuestions.map((updatedQuestion) {
        Map<String, dynamic>? oldQuestion = oldQuestions.firstWhere(
            (q) => q['id'] == updatedQuestion['id'],
            orElse: () => {});
        return {
          ...oldQuestion,
          ...updatedQuestion,
        };
      }).toList();
      sections[sectionKey] = mergedQuestions;
    });
  }

  void _deleteQuestion(String sectionKey, Map<String, dynamic> question) {
    setState(() {
      sections[sectionKey]?.remove(question);
      deletedQuestions
          .add({'section': sectionKey, 'question': question['question']});
      print("Marked for deletion: ${question['question']}");
    });
  }

  Future<void> _fetchQuestions() async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.100.46/database/questionaire/get_question.php'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedData = jsonDecode(response.body);
        setState(() {
          sections = {};
          decodedData.forEach((key, value) {
            if (value is List) {
              sections[key] = List<Map<String, dynamic>>.from(value.map((q) {
                if (q is Map<String, dynamic>) {
                  return {
                    'id': q['id'] ?? '', // Add unique identifier
                    'question': q['question']?.toString() ?? 'No Question',
                    'type': q['type'] ?? '',
                    'required': q['required'] ?? 0, // Include required field
                    'choices': (q['choices'] is List)
                        ? List<Map<String, dynamic>>.from(
                            q['choices'].map((choice) {
                            return {
                              'choice_id': choice['choice_id'] ?? '',
                              'choice_text': choice['choice_text'] ?? '',
                            };
                          }))
                        : [],
                  };
                } else {
                  return {};
                }
              }));
            }
          });
          sectionNumbers = List.generate(sections.length, (index) => index + 1);
        });
      }
    } catch (e) {
      print("Error fetching questions: $e");
    }
  }

  Future<void> _saveSurvey() async {
    List<Map<String, dynamic>> surveyData = [];

    sections.forEach((section, questions) {
      for (var question in questions) {
        surveyData.add({
          'section': section,
          'old_question': question['old_question'] ?? question['question'],
          'question': question['question'],
          'type': question['type'],
          'choices': question['choices'],
          'required': question['required'] ?? 0,
        });
      }
    });

    try {
      final response = await http.post(
        Uri.parse(
            'http://192.168.100.46/database/questionaire/save_changes.php'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
            {'questions': surveyData, 'deletedQuestions': deletedQuestions}),
      );

      if (response.statusCode == 200) {
        print("Survey saved successfully!");
        // Clear the deleted questions list after successful save
        deletedQuestions.clear();
      } else {
        print("Failed to save survey: ${response.body}");
      }
    } catch (e) {
      print("Error saving survey: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
      double width = constraints.maxWidth;
      double height = constraints.maxHeight;
      double remainingHeight = height - 100 - 20 - 20 - 32 - 10;

      return Column(
        children: [
          const CustomHeader(label: "Survey"),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      label: "Add Section",
                      svgPath: "svg/icons/+.svg",
                      onPressed: _addSection,
                    ),
                    const SizedBox(width: 10),
                    ShowButton(
                      label: "Save Changes",
                      onPressed: _saveSurvey,
                      svgPath: "svg/icons/floppy-disk.svg",
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: width,
                  height: remainingHeight,
                  child: SingleChildScrollView(
                    child: Column(
                      spacing: 20,
                      children: sectionNumbers.map((sectionNumber) {
                        String sectionKey = 'Section $sectionNumber';
                        return SurveySection(
                          sectionNumber: sectionNumber,
                          questions: List<Map<String, dynamic>>.from(
                            sections[sectionKey] ?? [],
                          ),
                          onSectionUpdated: (updatedQuestions) {
                            _updateSection(sectionKey, updatedQuestions);
                          },
                          onQuestionDeleted: (question) {
                            _deleteQuestion(sectionKey, question);
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
