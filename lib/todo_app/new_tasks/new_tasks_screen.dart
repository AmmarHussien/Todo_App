import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/component/componants.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

class NewTaskScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: ( context, state) {  },
      builder: ( context, Object? state) {
        var tasks = AppCubit.get(context).newTasks;
        return
          ConditionalBuilder(
            builder: (context) => ListView.separated(
              itemBuilder: (context,index) => buildTaskItem(tasks[index],context),
              separatorBuilder: (context,index) => Padding(
                padding: const EdgeInsetsDirectional.only(
                    start: 20.0
                ),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color:  Colors.grey[300],
                ),
              ),
              itemCount: tasks.length,
            ),
              condition: tasks.length>0,
            fallback: (context) =>
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.menu,
                    size: 100.0,
                    color: Colors.grey,
                  ),
                  Text(
                    'No Tasks Yet, please Add Some Tasks',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),

          );
      },
    );
  }
}
