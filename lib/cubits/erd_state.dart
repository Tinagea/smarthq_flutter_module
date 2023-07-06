part of 'erd_cubit.dart';

@immutable
abstract class ErdState {}

class ErdInitial extends ErdState {}

class ErdSelected extends ErdState {
  final ERD erd;
  ErdSelected(this.erd);
}

class ErdActionSuccess extends ErdState {
  final String message;
  final ERD erd;
  ErdActionSuccess(this.message, this.erd);
}

class ErdActionFailure extends ErdState {
  final String message;
  final ERD erd;
  ErdActionFailure(this.message, this.erd);
}

class ErdCleared extends ErdState {}

class ErdLoading extends ErdState {}

/// TODO: Interapt - the class should not be immutable if it's using in the way
/// This class (or a class that this class inherits from) is marked as '@immutable',
/// but one or more of its instance fields aren't final
// ignore: must_be_immutable
class ErdLoaded extends ErdState {
  final Map<dynamic, dynamic>? response;
  List<String>? exceptions;
  ErdLoaded(this.response, {this.exceptions});
}

class ErdException {
  static const String IS_TIMER_UPDATE = "IS_TIMER_UPDATE";
}
