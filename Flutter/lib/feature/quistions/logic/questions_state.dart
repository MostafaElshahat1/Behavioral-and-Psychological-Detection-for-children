// feature/quistions/logic/questions_state.dart
part of 'questions_cubit.dart';

abstract class QuestionsState {}

class QuestionsInitial extends QuestionsState {}

class QuestionsLoading extends QuestionsState {}

class QuestionsSuccess extends QuestionsState {
  final QuestionsTestResponse model;

  QuestionsSuccess(this.model);
}

class QuestionsFailure extends QuestionsState {
  final ErrorModel errorModel;

  QuestionsFailure(this.errorModel);
}

class QuestionsSubmitLoading extends QuestionsState {}

class QuestionsSubmitSuccess extends QuestionsState {
  final String message;

  QuestionsSubmitSuccess(this.message);
}

class QuestionsSubmitFailure extends QuestionsState {
  final ErrorModel errorModel;

  QuestionsSubmitFailure(this.errorModel);
}
