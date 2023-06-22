part of 'studying_manager_cubit.dart';

@immutable
abstract class StudyingManagerState extends Equatable {
  const StudyingManagerState();
  @override
  List<Object> get props => [];
}

class StudyingManagerLoading extends StudyingManagerState {}

class StudyingManagerInitial extends StudyingManagerState {}
class StudyingManagerTimeUp extends StudyingManagerState {}

class StudyingManagerStudying extends StudyingManagerState {
  final bool pause;
  final double progressP;
  final Duration passedTime;
  @override
  List<Object> get props => [pause, progressP,passedTime];

  const StudyingManagerStudying({required this.pause, 
  required this.progressP,
  required this.passedTime
  });
}

class StudyingManagerResting extends StudyingManagerState {



}
