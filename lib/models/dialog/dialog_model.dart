import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/models/dialog/dialog_type.dart';
import 'package:smarthq_flutter_module/resources/channels/dialog_parameter/dialog_parameter.dart';

@immutable
abstract class DialogState extends Equatable {}

class DialogInitial extends DialogState {
  @override
  List<Object?> get props => [];
}

class DialogShow extends DialogState {
  final DialogType dialogType;
  final DialogParameter? dialogParameter;

  DialogShow({
    required this.dialogType,
    this.dialogParameter
  });

  @override
  List<Object?> get props => [
    dialogType,
    dialogParameter
  ];
}

class DialogClose extends DialogState {
  @override
  List<Object?> get props => [];
}