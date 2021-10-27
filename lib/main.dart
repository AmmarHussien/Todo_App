import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';
import 'package:todo_app/shared/network/local/cashe_helper.dart';
import 'package:todo_app/shared/network/remote/dio_helper.dart';
import 'package:todo_app/shared/styles/themes.dart';
import 'package:todo_app/todo_app/new_tasks/new_tasks_screen.dart';
import 'package:todo_app/todo_app_model/todo_layout.dart';

import 'bloc_observer.dart';


void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  Widget widget;

  bool? isDark = CacheHelper.getDate(key: 'isDark');


  runApp(MyApp(
    isDark: isDark,
  ));
}
class MyApp extends StatelessWidget
{

  bool? isDark;
  MyApp({Key? key,
    this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AppCubit()..changeAppMode(
          fromShared: isDark,
        ),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context , state ){},
        builder:(context , state )
        {
          return MaterialApp(
            debugShowCheckedModeBanner: false ,
            theme: lightTheme,
            themeMode: AppCubit.get(context).isDark ? ThemeMode.light: ThemeMode.dark,
            darkTheme: darkTheme,
            home: TodoLayout(),
          );
        } ,

      ),
    );

  }

}