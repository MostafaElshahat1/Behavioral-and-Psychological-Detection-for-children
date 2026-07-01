// feature/quistions/ui/questions_flow_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grade_project/core/helper/extention.dart';
import 'package:grade_project/core/routing/routs.dart';
import 'package:grade_project/feature/quistions/data/model/questions_test_model.dart';
import 'package:grade_project/feature/quistions/logic/questions_cubit.dart';
import 'package:grade_project/feature/quistions/ui/2ans/questions2ans_screen.dart';
import 'package:grade_project/feature/quistions/ui/4ans/questions4ans_screen.dart';

class QuestionsFlowScreen extends StatelessWidget {
  const QuestionsFlowScreen({super.key, this.testId = 10, this.onFinished});

  final int testId;
  final VoidCallback? onFinished;

  @override
  Widget build(BuildContext context) {
    return _QuestionsFlowView(testId: testId, onFinished: onFinished);
  }
}

class _QuestionsFlowView extends StatefulWidget {
  const _QuestionsFlowView({required this.testId, required this.onFinished});

  final int testId;
  final VoidCallback? onFinished;

  @override
  State<_QuestionsFlowView> createState() => _QuestionsFlowViewState();
}

class _QuestionsFlowViewState extends State<_QuestionsFlowView> {
  int _currentIndex = 0;
  final Map<int, QuestionOption> _selectedAnswers = <int, QuestionOption>{};

  void _saveAnswer(QuestionItem question, String selectedLabel) {
    final questionsCubit = context.read<QuestionsCubit>();
    
    for (final option in question.options) {
      if (option.text == selectedLabel || option.value == selectedLabel) {
        _selectedAnswers[question.id] = option;
        questionsCubit.addOrUpdateAnswer(
          questionId: question.id,
          value: option.value.isNotEmpty ? option.value : option.text,
        );
        return;
      }
    }
    _selectedAnswers[question.id] = QuestionOption(
      id: -1,
      text: selectedLabel,
      value: selectedLabel,
    );
    questionsCubit.addOrUpdateAnswer(
      questionId: question.id,
      value: selectedLabel,
    );
  }

  Future<void> _submitQuiz(BuildContext context) async {
    await context.read<QuestionsCubit>().submitQuiz(quizId: widget.testId);
  }

  void _nextQuestion(List<QuestionItem> questions) {
    final currentQuestion = questions[_currentIndex];
    if (!_selectedAnswers.containsKey(currentQuestion.id)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please choose an answer first')),
      );
      return;
    }

    if (_currentIndex < questions.length - 1) {
      setState(() {
        _currentIndex++;
      });
      return;
    }

    _submitQuiz(context);
  }

  @override
  Widget build(BuildContext context) {
     bool _isLoadingDialogVisible = false;

  void _showLoadingDialog(BuildContext context) {
    if (_isLoadingDialogVisible) return;
    _isLoadingDialogVisible = true;
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    ).then((_) {
      _isLoadingDialogVisible = false;
    });
  }

  void _hideLoadingDialog(BuildContext context) {
    if (!_isLoadingDialogVisible) return;
    try {
      Navigator.of(context, rootNavigator: true).pop();
    } catch (_) {}
    _isLoadingDialogVisible = false;
  }

    return BlocConsumer<QuestionsCubit, QuestionsState>(
      buildWhen: (previous, current) {
        return current is QuestionsInitial ||
            current is QuestionsLoading ||
            current is QuestionsFailure ||
            current is QuestionsSuccess;
      },
      listener: (context, state) {
        if (state is QuestionsSubmitLoading) {
          _showLoadingDialog(context);
        } else {
          _hideLoadingDialog(context);
        }
        if (state is QuestionsSubmitSuccess) {
          //print('Quiz submitted successfully:------ ${state.message}');
          context.read<QuestionsCubit>().clearAnswers();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
          context.pushNamedAndRemoveUntil(
            IRouts.thankYouScreen,
            predicate: (route) => false,
          );
        } else if (state is QuestionsSubmitFailure) {
          //print('Quiz submit failed:------ ${state.errorModel}');

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorModel.errorMessages?.join(', ') ??
                    'Failed to submit quiz',
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is QuestionsLoading || state is QuestionsInitial) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is QuestionsFailure) {
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      state.errorModel.errorMessages?.join(', ') ??
                          'An error occurred',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        context.read<QuestionsCubit>().getQuestionsById(
                          widget.testId,
                        );
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        if (state is! QuestionsSuccess || state.model.result == null) {
          return const Scaffold(
            body: Center(child: Text('No questions found')),
          );
        }

        final questions = state.model.result!.questions;
        if (questions.isEmpty) {
          return const Scaffold(
            body: Center(child: Text('No questions found')),
          );
        }

        if (_currentIndex >= questions.length) {
          _currentIndex = questions.length - 1;
        }

        final question = questions[_currentIndex];
        final options = question.options;
        final optionLabels = options
            .map((e) => e.text.isNotEmpty ? e.text : e.value)
            .toList();

        if (options.length == 2) {
          final twoOptions = optionLabels.length >= 2
              ? optionLabels.take(2).toList()
              : <String>['YES', 'No'];

          return QuestionsScreen2ans(
            key: ValueKey('question-2ans-${question.id}'),
            currentStep: _currentIndex + 1,
            totalSteps: questions.length,
            question: question.text,
            options: twoOptions,
            onOptionChanged: (answer) => _saveAnswer(question, answer),
            onNextTap: () => _nextQuestion(questions),
            isLastStep: _currentIndex == questions.length - 1,
          );
        }

        return QuestionsScreen4ans(
          key: ValueKey('question-4ans-${question.id}'),
          currentStep: _currentIndex + 1,
          totalSteps: questions.length,
          question: question.text,
          options: optionLabels,
          onAnswerChanged: (answer) => _saveAnswer(question, answer),
          onNextTap: () => _nextQuestion(questions),
          isLastStep: _currentIndex == questions.length - 1,
        );
      },
    );
  }
}
