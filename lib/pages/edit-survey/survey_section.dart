import 'package:css_website_access/pages/edit-survey/show_dialog_survey.dart';
import 'package:css_website_access/pages/edit-survey/survey_button.dart';
import 'package:css_website_access/pages/edit-survey/survey_item.dart';
import 'package:flutter/material.dart';

class SurveySection extends StatefulWidget {
  final int sectionNumber;
  final List<Map<String, dynamic>> questions;
  final Function(List<Map<String, dynamic>>) onSectionUpdated;
  final Function(Map<String, dynamic>) onQuestionDeleted;

  const SurveySection({
    super.key,
    required this.sectionNumber,
    required this.questions,
    required this.onSectionUpdated,
    required this.onQuestionDeleted,
  });

  @override
  State<SurveySection> createState() => _SurveySectionState();
}

class _SurveySectionState extends State<SurveySection> {
  List<Map<String, dynamic>> surveyItems = [];

  @override
  void initState() {
    super.initState();
    surveyItems = List<Map<String, dynamic>>.from(widget.questions);
  }

  void _updateQuestion(int index, String newQuestion, String oldQuestion) {
    setState(() {
      surveyItems[index]['question'] = newQuestion;
      surveyItems[index]['old_question'] = oldQuestion;
    });
    _autoSave();
  }

  void _updateChoices(int index, List<Map<String, dynamic>> newChoices) {
    setState(() {
      surveyItems[index]['choices'] = newChoices;
    });
    _autoSave();
  }

  void _autoSave() {
    widget.onSectionUpdated(surveyItems);
    print("Auto-Saving Updated Survey Data: $surveyItems");
  }

  void _updateRequired(int index, int requiredValue) {
    setState(() {
      surveyItems[index]['required'] = requiredValue;
    });
    _autoSave();
  }

  void _deleteQuestion(int index) {
    setState(() {
      Map<String, dynamic> deletedQuestion = {
        'section': "Section ${widget.sectionNumber}",
        'question': surveyItems[index]['question'],
      };
      surveyItems.removeAt(index);
      widget.onQuestionDeleted(deletedQuestion);
    });
    _autoSave();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F7F9),
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 3, spreadRadius: 1),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF48494A)),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(Icons.drag_indicator),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF48494A)),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text("Section ${widget.sectionNumber}"),
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  SurveyButton(
                    svgPath: "svg/icons/+.svg",
                    text: 'Add Item',
                    onPressed: () {
                      showDialogSurvey(context, (selectedChoice) {
                        setState(() {
                          surveyItems.add({
                            'type': selectedChoice,
                            'question': 'New Question',
                            'choices': [],
                          });
                        });
                        _autoSave();
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEE2E2),
                      border: Border.all(color: const Color(0xFFEF4444)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: IconButton(
                      color: const Color(0xFFEF4444),
                      icon: const Icon(Icons.delete),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: const Divider(
              color: Color(0xFF86898A),
            ),
          ),
          Column(
            children: List.generate(surveyItems.length, (index) {
              print(
                  "Required Value for Question ${index + 1}: ${surveyItems[index]['required']}");
              return SurveyItem(
                type: surveyItems[index]['type'] ?? '',
                question: surveyItems[index]['question'] ?? 'No Question',
                choices: List<Map<String, dynamic>>.from(
                    surveyItems[index]['choices'] ?? []),
                required:
                    int.tryParse(surveyItems[index]['required'].toString()) ??
                        0,
                onQuestionChanged: (newQuestion, oldQuestion) {
                  _updateQuestion(index, newQuestion, oldQuestion);
                },
                onChoicesChanged: (newChoices) {
                  _updateChoices(index, newChoices);
                },
                onRequiredChanged: (int value) {
                  _updateRequired(index, value);
                },
                onDelete: () => _deleteQuestion(index),
              );
            }),
          ),
        ],
      ),
    );
  }
}
