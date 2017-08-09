import 'dart:html';

import 'package:angular/angular.dart';
import 'package:np8080/src/dialog/common/editorcomponentbase.dart';
import 'package:np8080/src/services/eventbusservice.dart';
import 'package:np8080/src/services/textareadomservice.dart';
import 'package:np8080/src/services/textprocessingservice.dart';
import 'package:np8080/src/services/themeservice.dart';

@Component(
    selector: 'markdown-preview',
    templateUrl: 'markdownpreview.html',
    directives: const [NgModel, NgStyle, NgClass])
class MarkdownPreview extends EditorComponentBase implements OnChanges {
  final NullTreeSanitizer _nullSanitizer = new NullTreeSanitizer();

  DivElement _htmlDiv;

  MarkdownPreview(
      TextProcessingService newTextProcessingService,
      TextareaDomService newTextareaDomService,
      ThemeService newThemeService,
      EventBusService newEventBusService)
      : super(newTextProcessingService, newTextareaDomService, newThemeService,
            newEventBusService);
  @Input('content')
  String content = "";

  @Input('active')
  bool active;

  @override
  ngOnChanges(Map<String, SimpleChange> changes) {
    if (active || changes.containsKey("active")) updatePreview();
  }

  void updatePreview() {
    _htmlDiv ??= querySelector('#previewPane');

    _htmlDiv.setInnerHtml(textProcessingService.convertMarkdownToHtml(content),
        treeSanitizer: _nullSanitizer);
  }
}

class NullTreeSanitizer implements NodeTreeSanitizer {
  void sanitizeTree(Node node) {}
}