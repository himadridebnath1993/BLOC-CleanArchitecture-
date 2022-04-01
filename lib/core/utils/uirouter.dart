import 'package:deep_rooted_task/screens/currency_pair/presentation/page/currency_page.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class UIRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HOME_SEARCH_ROUTE:
        return MaterialPageRoute(builder: (_) => CurrencyPage());
      default:
        return MaterialPageRoute(builder: (_) => CurrencyPage());
    }
  }
}
