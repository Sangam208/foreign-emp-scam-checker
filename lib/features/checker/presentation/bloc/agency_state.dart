part of 'agency_bloc.dart';

@immutable
sealed class AgencyState {}

final class AgencyInitial extends AgencyState {}

final class AgencyLoading extends AgencyState {}

final class AgencySuccess extends AgencyState {
  final List<Agency> agenciesList;
  AgencySuccess(this.agenciesList);
}

final class AgencyFailure extends AgencyState {
  final String message;
  AgencyFailure(this.message);
}
