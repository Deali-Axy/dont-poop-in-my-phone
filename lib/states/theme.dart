import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import 'package:dont_poop_in_my_phone/common/global.dart';

class ThemeState with ChangeNotifier, DiagnosticableTreeMixin {
  bool get darkMode => Global.appConfig.darkMode;

  bool get material3 => Global.appConfig.material3;

  set darkMode(bool value) {
    Global.appConfig.darkMode = value;
    notifyListeners();
  }

  set material3(bool value) {
    Global.appConfig.material3 = value;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(FlagProperty('darkMode', value: darkMode));
  }

  @override
  void notifyListeners() {
    Global.saveAppConfig();
    super.notifyListeners();
  }
}
