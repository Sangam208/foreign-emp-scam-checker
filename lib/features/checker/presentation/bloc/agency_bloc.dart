import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foreign_emp_scam_checker/features/auth/domain/usecases/user_sign_in.dart';
import 'package:foreign_emp_scam_checker/features/checker/domain/entities/agency.dart';
import 'package:foreign_emp_scam_checker/features/checker/domain/usecases/fetch_agencies.dart';

part 'agency_event.dart';
part 'agency_state.dart';

class AgencyBloc extends Bloc<AgencyEvent, AgencyState> {
  final FetchAgencies _agenciesFetch;

  AgencyBloc({
    required FetchAgencies agenciesFetch,
  }) : _agenciesFetch = agenciesFetch,
       super(AgencyInitial()) {
    on<AgencyEvent>((_, emit) => emit(AgencyLoading()));
    on<AgencyLoadData>(_onAgencyLoadData);
  }

  void _onAgencyLoadData(
    AgencyLoadData event,
    Emitter<AgencyState> emit,
  ) async {
    final res = await _agenciesFetch(NoParams());

    res.fold(
      (l) => emit(AgencyFailure(l.message)),
      (r) => emit(AgencySuccess(r)),
    );
  }
}
