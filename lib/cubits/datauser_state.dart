import 'package:equatable/equatable.dart';

import '../models/data_user.dart';

abstract class DataUserState extends Equatable {
  const DataUserState();

  @override
  List<Object> get props => [];
}

class DataUserInitial extends DataUserState {

}

class DataUserLoaded extends DataUserState {
  final DataUser? dataUser;

  const DataUserLoaded({this.dataUser});

  @override
  List<Object> get props => [dataUser!];
}

class DataUserLoadingFailed extends DataUserState {
  final String? message;

  const DataUserLoadingFailed(this.message);

  @override
  List<Object> get props => [message!];
}