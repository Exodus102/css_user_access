import 'package:css_website_access/widgets/custom_header.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Question {
  final String id;
  final String question;
  final String type;
  final bool required;
  final List<Choice> choices;

  Question({
    required this.id,
    required this.question,
    required this.type,
    required this.required,
    required this.choices,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'].toString(),
      question: json['question'],
      type: json['type'],
      required: json['required'] == 1,
      choices: (json['choices'] as List)
          .map((choice) => Choice.fromJson(choice))
          .toList(),
    );
  }
}

class Choice {
  final String id;
  final String choiceText;

  Choice({
    required this.id,
    required this.choiceText,
  });

  factory Choice.fromJson(Map<String, dynamic> json) {
    return Choice(
      id: json['choice_id'].toString(),
      choiceText: json['choice_text'],
    );
  }
}

class SurveyService {
  static const String baseUrl =
      'http://192.168.100.46/database/questionaire/get_question.php';

  Future<Map<String, List<Question>>> getSurveyQuestions() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data.map((section, questions) => MapEntry(
              section,
              (questions as List).map((q) => Question.fromJson(q)).toList(),
            ));
      } else {
        throw Exception(
            'Failed to load survey questions: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching survey questions: $e');
    }
  }
}

class Survey extends StatefulWidget {
  const Survey({super.key});

  @override
  State<Survey> createState() => _SurveyState();
}

class _SurveyState extends State<Survey> {
  late Future<Map<String, List<Question>>> _questionsFuture;
  final SurveyService _surveyService = SurveyService();

  @override
  void initState() {
    super.initState();
    _questionsFuture = _surveyService.getSurveyQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
      final double width = constraints.maxWidth;
      final double height = constraints.maxHeight;
      final double remainingHeight = height - (100.0 + 40);

      return Column(
        children: [
          CustomHeader(
            label: "Survey",
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: SizedBox(
              width: width,
              height: remainingHeight,
              child: SingleChildScrollView(
                child: FutureBuilder<Map<String, List<Question>>>(
                  future: _questionsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No questions found'));
                    }

                    final sections = snapshot.data!;

                    return Column(
                      children: sections.entries.map((sectionEntry) {
                        final sectionName = sectionEntry.key;
                        final questions = sectionEntry.value;

                        return Column(
                          children: questions
                              .map((question) => Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF1F7F9),
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 3,
                                          spreadRadius: 1,
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color:
                                                      const Color(0xFF48494A)),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(sectionName),
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 60),
                                            child: const Divider(
                                              color: Color(0xFF86898A),
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 1,
                                                color: Color(0xFF48494A),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(question.type),
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          Text(
                                            question.question,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          SizedBox(height: 10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: question.choices
                                                .asMap()
                                                .entries
                                                .map((entry) {
                                              final int index = entry.key +
                                                  1; // Add 1 to start numbering from 1
                                              final Choice choice = entry.value;
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4.0),
                                                child: Text(
                                                  '$index. ${choice.choiceText}',
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                          SizedBox(height: 20),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 60),
                                            child: const Divider(
                                              color: Color(0xFF86898A),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ))
                              .toList(),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
