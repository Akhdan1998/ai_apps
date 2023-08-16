import 'package:bloc/bloc.dart';

import '../models/api_return_history.dart';
import '../models/history.dart';
import '../services/history_services.dart';
import 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitial());

  Future<void> getHistory(String token) async {
    ApiReturnHistory<List<HistoryModel>>? result = await HistoryServices.getHistory(token);

    if (result?.value != null) {
      emit(HistoryLoaded(history: result?.value));
    } else {
      emit(HistoryLoadingFailed(result?.message));
    }
  }
}
