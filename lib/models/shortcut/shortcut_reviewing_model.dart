import 'package:equatable/equatable.dart';
import 'package:smarthq_flutter_module/models/shortcut/shortcut_model.dart';

abstract class ShortcutReviewingState extends Equatable {}

class ShortcutReviewingInitiate extends ShortcutReviewingState {
  @override
  List<Object?> get props => [];
}

class ShortcutReviewingSavedShortcut extends ShortcutReviewingState {
  final ShortcutSetListModel? model;

  ShortcutReviewingSavedShortcut({
    required this.model
  });

  @override
  List<Object?> get props => [
    this.model
  ];

  @override
  String toString() => "ShortcutReviewingSavedShortcut {"
      "model: $model\n"
      "}";
}