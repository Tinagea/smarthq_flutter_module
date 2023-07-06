
enum EntryPointType {
  /// This is a main entry point.
  /// This entry point has all the Widget related to UI
  /// and the DataModel for SmartHQ Home.
  main,

  /// This is a dialog entry point.
  /// This entry point has only the widget related to Dialog
  /// and some part that calls REST Api to configure the Dialog.
  dialog
}