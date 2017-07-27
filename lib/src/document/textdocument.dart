import 'dart:html';

import '../resources/resources.dart';

class TextDocument {
  int _id = 1;
  String _text = '';
  String _downloadName;
  DateTime lastModified;

  bool get empty => _text.length == 0;

  String get downloadName => _downloadName;
  String get text => _text;
  String get storedText => window.localStorage['id1'];

  set downloadName(String value) {
    _downloadName = value;
    save();
  }

  final List<String> _undoText = new List<String>();

  TextDocument() {
    initText();
    initLastModifiedDate();
    initDownloadName();
  }

  void initText() {
    _text = storedText;
    if (_text == null) _text = welcomeText;
  }

  void initDownloadName() {
    _downloadName = window.localStorage['dn1'];
    if (_downloadName == null) downloadName = "np8080.txt";
  }

  void reset() {
    downloadName = "np8080.txt";
    updateModifiedDate();
  }

  void initLastModifiedDate() {
    String lms = window.localStorage['lm1'];

    if (lms != null) {
      lastModified = DateTime.parse(lms);
    }
  }

  void updateModifiedDate() => lastModified = new DateTime.now();

  void updateAndSave(String newText) {
    _text = newText;
    save();
  }

  void appendAndSave(String additionalText) {
    _text += additionalText;
    save();
  }

  void save() {
    if (_text != storedText) {
      updateUndoBuffer();
    }
    performSave();
  }

  void updateUndoBuffer() {
    if ((_undoText.length == 0) ||
        (_undoText.length > 0 &&
            _undoText[_undoText.length - 1] != storedText)) {
      _undoText.add(storedText);
    }
  }

  void performSave() {
    updateModifiedDate();
    window.localStorage['id' + _id.toString()] = _text;
    window.localStorage['dn' + _id.toString()] = _downloadName;
    window.localStorage['lm' + _id.toString()] = lastModified.toIso8601String();
  }

  void undo() {
    _text = _undoText.removeLast();
    performSave();
  }
}