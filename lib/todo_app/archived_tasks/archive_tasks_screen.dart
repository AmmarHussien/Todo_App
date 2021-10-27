import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_app/shared/component/componants.dart';


import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';


class ArchiveTaskScreen extends StatelessWidget {
  const ArchiveTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: ( context, state) {  },
      builder: ( context, Object? state) {
        var tasks = AppCubit.get(context).archivedTasks;
        return
          tasksBuilder(
            tasks: tasks,
          );
      },
    );
  }
}
