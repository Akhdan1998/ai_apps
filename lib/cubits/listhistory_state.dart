import 'package:equatable/equatable.dart';

import '../models/history.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HistoryInitial extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<HistoryModel>? history;

  HistoryLoaded({this.history});

  @override
  List<Object> get props => [history!];
}

class HistoryLoadingFailed extends HistoryState {
  final String? message;

  HistoryLoadingFailed(this.message);

  @override
  List<Object> get props => [message!];
}