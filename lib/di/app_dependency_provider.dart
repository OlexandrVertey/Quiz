import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/provider/main_provider.dart';
import 'package:quiz/result_db/result_db.dart';
import 'package:quiz/shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

void runAppWithInjectedDependencies({required Widget app}) async {
  final selectCardsDB = ResultDB.internal();
  final sharedPreference = await SharedPreferences.getInstance();
  runApp(
    BaseDependenciesProvider(
      selectCardsDB: selectCardsDB,
      sharedPreference: sharedPreference,
      child: app,
    ),
  );
}

class BaseDependenciesProvider extends MultiProvider {
  BaseDependenciesProvider({
    Key? key,
    required ResultDB selectCardsDB,
    required SharedPreferences sharedPreference,
    required Widget child,
  }) : super(
          key: key,
          providers: [
            Provider<ResultDB>.value(value: selectCardsDB),
            Provider<SharedPreferences>.value(value: sharedPreference),
            Provider<SharedPreference>(create: (context) => SharedPreference(sharedPreference)),
          ],
          child: DependenciesProvider(
            // selectCardsDB: selectCardsDB,
            sharedPreference: sharedPreference,
            child: child,
          ),
        );
}


class DependenciesProvider extends StatelessWidget {
  const DependenciesProvider({
    Key? key,
    required this.child,
    required SharedPreferences sharedPreference,
  }) : super(key: key);

  final Widget? child;
  // final SharedPreferences? sharedPreference;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MainProvider(
            resultDB: context.read<ResultDB>(),
            sharedPreference: context.read<SharedPreference>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
