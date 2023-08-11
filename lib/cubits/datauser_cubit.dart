import 'package:bloc/bloc.dart';

import '../models/api_return_data.dart';
import '../models/data_user.dart';
import '../services/datauser_services.dart';
import 'datauser_state.dart';

class DataUserCubit extends Cubit<DataUserState> {
  DataUserCubit() : super(DataUserInitial());

  Future<void> getData(String token) async {
    ApiReturnData<DataUser>? result =
    await DataUserServices.getData(token);
    if (result?.value != null) {
      emit(DataUserLoaded(dataUser: result?.value));
    } else {
      emit(DataUserLoadingFailed(result?.message));
    }
  }
}