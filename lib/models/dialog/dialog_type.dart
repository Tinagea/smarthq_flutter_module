
enum DialogType {
  initial('/'),
  pushNotification('pushNotification');

  const DialogType(this.name);
  final String name;

  factory DialogType.getTypeFrom({required String name}) {
    return DialogType.values.firstWhere((value) => value.name == name,
        orElse: () => DialogType.initial);
  }
}