import 'package:flutter/material.dart';

class FAQ {
  final String category;
  final List<Question> questions;

  const FAQ({
    required this.category,
    required this.questions,
  });
}

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class Question {
  final String question;
  final String answer;

  const Question(this.question, this.answer);
}

class _FaqScreenState extends State<FaqScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<FAQ> _filteredFaqs = [];
  final List<FAQ> _allFaqs = [
    const FAQ(
      category: 'General',
      questions: [
        Question(
          'What is NIST College?',
          'NIST College is a premier engineering institution...',
        ),
        Question(
          'How do I contact support?',
          'You can reach our support team through...',
        ),
      ],
    ),
    const FAQ(
      category: 'Academics',
      questions: [
        Question(
          'How do I check my attendance?',
          'You can view your attendance in the dashboard section...',
        ),
        Question(
          'How do I view my results?',
          'Results can be accessed through the academic section...',
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "FAQ",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.2,
          ),
        ),
      ),
      body: Column(
        children: [
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextField(
                  controller: _searchController,
                  onChanged: _filterFaqs,
                  decoration: InputDecoration(
                    hintText: 'Search FAQs',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: theme.colorScheme.surface,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              itemCount: _filteredFaqs.length,
              itemBuilder: (context, index) {
                final faq = _filteredFaqs[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      faq.category,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            theme.colorScheme.surface,
                            theme.colorScheme.surfaceContainerHighest
                                .withOpacity(0.5),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color:
                              theme.colorScheme.outlineVariant.withOpacity(0.5),
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
                        data: Theme.of(context)
                            .copyWith(dividerColor: Colors.transparent),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: faq.questions.length,
                          itemBuilder: (context, questionIndex) {
                            return ExpansionTile(
                              title: Text(
                                faq.questions[questionIndex].question,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 0, 16, 16),
                                  child: Text(
                                    faq.questions[questionIndex].answer,
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _filteredFaqs = _allFaqs;
  }

  void _filterFaqs(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredFaqs = _allFaqs;
      } else {
        _filteredFaqs = _allFaqs
            .map((faq) {
              final filteredQuestions = faq.questions.where((q) {
                return q.question.toLowerCase().contains(query.toLowerCase()) ||
                    q.answer.toLowerCase().contains(query.toLowerCase());
              }).toList();
              return FAQ(
                category: faq.category,
                questions: filteredQuestions,
              );
            })
            .where((faq) => faq.questions.isNotEmpty)
            .toList();
      }
    });
  }
}
