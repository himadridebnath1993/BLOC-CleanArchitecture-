
import 'package:deep_rooted_task/core/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:deep_rooted_task/core/utils/constants.dart';
import 'package:logging/logging.dart';
 import 'core/utils/uirouter.dart';
import 'injection_container.dart' as di; //Dependency injector

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di
      .init(); //Inject all the dependencies and wait for it is done (i.e. UI won't built until all the dependencies are injected)
  _setupLogging();
  runApp(CleanArchitectureWithBloc());
}

class CleanArchitectureWithBloc extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'clean architecture with bloc',
      theme: CustomTheme.mainTheme,
      onGenerateRoute: UIRouter.generateRoute,
      initialRoute: HOME_SEARCH_ROUTE,
    );
  }
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}
