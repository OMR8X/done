import 'package:done/core/injection_container.dart';
import 'package:done/core/services/sqflite_initializer.dart';
import 'package:done/core/theme/theme_data.dart';
import 'package:done/screens/2_pages/view/pages_holder.dart';
import 'package:done/screens/5_studying/cubit/cubit/studying_manager_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'cubit/cubit/app_data_holder_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getInit();
  await SqfliteInitializer.initDataBase();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => StudyingManagerCubit()),
      BlocProvider(create: (context) => AppDataHolderCubit()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    context.read<AppDataHolderCubit>().init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Done',
      theme: CustomAppTheme.getTheme(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("ar"),
      ],
      home: BlocBuilder<AppDataHolderCubit, AppDataHolderState>(
        builder: (context, state) {
 
          if (state is AppDataHolderInitial) {
            return const PagesHolder();
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            ),
          );
        },
      ),
    );
  }
}
