import 'package:equatable/equatable.dart';
import 'package:smarthq_flutter_module/models/shortcut/shortcut_model.dart';

abstract class ShortcutReviewState extends Equatable {}

class ShortcutReviewInitiate extends ShortcutReviewState {
  @override
  List<Object?> get props => [];
}

class ShortcutReviewSavedShortcut extends ShortcutReviewState {
  final ShortcutSetItemModel? model;

  ShortcutReviewSavedShortcut({
    required this.model
  });

  @override
  List<Object?> get props => [
    this.model
  ];

  @override
  String toString() => "ShortcutReviewSavedShortcut {"
      "model: $model\n"
      "}";
}

class ShortcutReviewShortcutSavingSucceeded extends ShortcutReviewState {
  @override
  List<Object?> get props => [];
}