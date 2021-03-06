import 'package:angular/angular.dart';

import 'package:np8080/src/dialog/common/componentbase.dart';
import 'package:np8080/src/resources/resources.dart';
import 'package:np8080/src/services/eventbusservice.dart';
import 'package:np8080/src/services/themeservice.dart';

@Component(
    selector: 'about-dialog',
    templateUrl: 'aboutdialog.html',
    directives: [NgClass])
class AboutDialogComponent extends ComponentBase {
  final String aboutText = welcomeText;

  AboutDialogComponent(
      ThemeService newthemeService, EventBusService newEventBusService)
      : super(newthemeService, newEventBusService) {
    eventBusService.subscribe("showAboutDialog", show);
  }
}
