import 'package:get/get.dart';

const Map<String, String> appBarTitle = {
  'Event Calendar': 'Календарь Событий',
};
const Map<String, String> addEventHintText = {
  'Add title of the event': 'Введите заголовок события'
};
// const Map<String, String> switchCalendarText = {
//   'Month': 'Месяц',
//   'Week': 'Неделя'
// };

class TextResources extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ru': {
          ...appBarTitle,
          ...addEventHintText,
        },
      };
}
