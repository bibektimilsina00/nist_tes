import 'package:flutter/material.dart';

// Sample data
final Map<String, dynamic> evaluationData = {
  "evaluationFormId": "00092859-15b2-43a4-974f-5b8d98a60acb",
  "name": "Teacher Evaluation Form",
  "categories": [
    {
      "categoryTitle": "Teaching Methods",
      "questions": [
        {
          "id": "q1",
          "label": "How effectively does the teacher explain complex concepts?",
          "type": "objective",
          "options": [
            {"id": "opt1", "value": "1 - Poor"},
            {"id": "opt2", "value": "2 - Fair"},
            {"id": "opt3", "value": "3 - Good"},
            {"id": "opt4", "value": "4 - Very Good"},
            {"id": "opt5", "value": "5 - Excellent"}
          ]
        },
        {
          "id": "q2",
          "label": "How well does the teacher encourage class participation?",
          "type": "objective",
          "options": [
            {"id": "opt6", "value": "1 - Poor"},
            {"id": "opt7", "value": "2 - Fair"},
            {"id": "opt8", "value": "3 - Good"},
            {"id": "opt9", "value": "4 - Very Good"},
            {"id": "opt10", "value": "5 - Excellent"}
          ]
        }
      ]
    },
    {
      "categoryTitle": "Course Materials",
      "questions": [
        {
          "id": "q3",
          "label": "How would you rate the quality of course materials?",
          "type": "objective",
          "options": [
            {"id": "opt11", "value": "1 - Poor"},
            {"id": "opt12", "value": "2 - Fair"},
            {"id": "opt13", "value": "3 - Good"},
            {"id": "opt14", "value": "4 - Very Good"},
            {"id": "opt15", "value": "5 - Excellent"}
          ]
        },
        {
          "id": "q4",
          "label": "How relevant are the assignments to the course content?",
          "type": "objective",
          "options": [
            {"id": "opt16", "value": "1 - Poor"},
            {"id": "opt17", "value": "2 - Fair"},
            {"id": "opt18", "value": "3 - Good"},
            {"id": "opt19", "value": "4 - Very Good"},
            {"id": "opt20", "value": "5 - Excellent"}
          ]
        }
      ]
    },
    {
      "categoryTitle": "Assessment Methods",
      "questions": [
        {
          "id": "q5",
          "label": "How fair is the grading system?",
          "type": "objective",
          "options": [
            {"id": "opt21", "value": "1 - Poor"},
            {"id": "opt22", "value": "2 - Fair"},
            {"id": "opt23", "value": "3 - Good"},
            {"id": "opt24", "value": "4 - Very Good"},
            {"id": "opt25", "value": "5 - Excellent"}
          ]
        },
        {
          "id": "q6",
          "label": "How timely is the feedback on assignments?",
          "type": "objective",
          "options": [
            {"id": "opt26", "value": "1 - Poor"},
            {"id": "opt27", "value": "2 - Fair"},
            {"id": "opt28", "value": "3 - Good"},
            {"id": "opt29", "value": "4 - Very Good"},
            {"id": "opt30", "value": "5 - Excellent"}
          ]
        }
      ]
    }
  ]
};

class EvaluationFormScreen extends StatefulWidget {
  const EvaluationFormScreen({super.key});

  @override
  State<EvaluationFormScreen> createState() => _EvaluationFormScreenState();
}

class _EvaluationFormScreenState extends State<EvaluationFormScreen> {
  final Map<String, String> _answers = {};

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Teacher Evaluation',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.2,
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 24),
        child: FilledButton(
          onPressed: _answers.length == 6 ? _handleSubmit : null,
          style: FilledButton.styleFrom(
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Text(
            'Submit Evaluation',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    theme.colorScheme.surface,
                    theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage('https://picsum.photos/200'),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Dr. John Doe',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Computer Networks',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: _answers.length / 6,
                    backgroundColor: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${_answers.length}/6 Questions Answered',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: evaluationData['categories'].length,
                itemBuilder: (context, index) {
                  final category = evaluationData['categories'][index];
                  return _buildCategorySection(
                    category['categoryTitle'],
                    category['questions'],
                    theme,
                  );
                },
              ),
            ),
            const SizedBox(height: 80), // Space for bottom button
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection(
      String title, List<dynamic> questions, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.surface,
            theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withOpacity(0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.assignment_outlined,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
          children: questions.map<Widget>((question) {
            return _buildQuestionCard(question, theme);
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildQuestionCard(Map<String, dynamic> question, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question['label'],
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 60,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: question['options'].map<Widget>((option) {
                  return Container(
                    margin: const EdgeInsets.only(right: 8),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _answers[question['id']] = option['id'];
                        });
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          gradient: _answers[question['id']] == option['id']
                              ? LinearGradient(
                                  colors: [
                                    theme.colorScheme.primary,
                                    theme.colorScheme.primary.withOpacity(0.8),
                                  ],
                                )
                              : null,
                          color: _answers[question['id']] == option['id']
                              ? null
                              : theme.colorScheme.surfaceContainerHighest
                                  .withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _answers[question['id']] == option['id']
                                ? theme.colorScheme.primary
                                : theme.colorScheme.outlineVariant
                                    .withOpacity(0.5),
                          ),
                        ),
                        child: Text(
                          option['value'],
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: _answers[question['id']] == option['id']
                                ? theme.colorScheme.onPrimary
                                : theme.colorScheme.onSurface,
                            fontWeight: _answers[question['id']] == option['id']
                                ? FontWeight.bold
                                : null,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleSubmit() {
    // Handle form submission
    print(_answers);
  }
}
