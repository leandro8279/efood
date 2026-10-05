import 'package:get/get.dart';

import 'en_us.dart' show enUs;
import 'pt_br.dart' show ptBr;

const Map<String, String> ptBR = ptBr;
const Map<String, String> enUS = enUs;

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'pt_BR': ptBR,
    'en_US': enUS,
  };
}
