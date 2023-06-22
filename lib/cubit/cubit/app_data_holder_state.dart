part of 'app_data_holder_cubit.dart';

abstract class AppDataHolderState extends Equatable {
  const AppDataHolderState();

  @override
  List<Object> get props => [];
}

class AppDataHolderLoading extends AppDataHolderState {}

class AppDataHolderInitial extends AppDataHolderState {
  final List<StudyingSession> lastSevenSession;
  final int fullSSessions, fullSHours;
  final double avgSHoursPerDay;
  @override
  List<Object> get props => [
        lastSevenSession,
        fullSSessions,
        fullSHours,
        avgSHoursPerDay,
      ];
  const AppDataHolderInitial(
      {required this.lastSevenSession,
      required this.fullSSessions,
      required this.avgSHoursPerDay,
      required this.fullSHours});
}
