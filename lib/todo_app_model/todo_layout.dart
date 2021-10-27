import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/shared/component/componants.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

import 'package:conditional_builder/conditional_builder.dart';
class TodoLayout extends StatelessWidget
{


  var scaffoldKey = GlobalKey<ScaffoldState>();

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override

  Widget build(BuildContext context)
  {

    return BlocProvider(
      create: (BuildContext context)=> AppCubit()..createDatabase(),
      child: BlocConsumer< AppCubit , AppStates>(
        listener: (BuildContext context, AppStates state)
        {
          if ( state is AppInsertDataBaseState)
            {
              Navigator.pop(context);
            }
        },
        builder: (BuildContext context, AppStates state)
        {
          AppCubit cubit = AppCubit.get(context);
          return  Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                cubit.titles[cubit.currentIndex],
              ),
            ),
            body:ConditionalBuilder(
              condition: state is! AppGetDataBaseLoadingState,
              builder:  (context) => cubit.screens[cubit.currentIndex],
              fallback: (context) => Center(
                child:  CircularProgressIndicator(),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async
              {
                // try
                // {
                //   var name = await getNAme();
                //   print(name);
                //
                //   throw('some error !!!!!');
                // } catch (error)
                // {
                //   print('error ${error.toString()}');
                // }
                /*getNAme().then((value) {
                      print(value);
                      print('osama');
                    }).catchError((error){
                      print('error is ${error.toString()}');
                    });*/
                //insertDatabase();
                if (cubit.isBottomSheetShown)
                {
                  cubit.insertDatabase(
                      title: titleController.text,
                      time: timeController.text,
                      date: dateController.text,
                  );
                  // insertDatabase(
                  //     date: dateController.text,
                  //     time: timeController.text,
                  //     title: titleController.text
                  // ).then((value)
                  // {
                  //   GetDataFromDataBase(database).then((value)
                  //   {
                  //     Navigator.pop(context);
                  //
                  //     // setState(() {
                  //     //   fabIcon =Icons.edit;
                  //     //   isBottomSheetShown = false;
                  //     //
                  //     //   tasks =value;
                  //     //   print(tasks);
                  //     // });
                  //   });
                  // });
                }
                else
                {
                  scaffoldKey.currentState!.showBottomSheet(
                        (context) => Container(
                      color: Colors.grey[100],
                      padding: const EdgeInsets.all(20.0,),
                      child: Column(
                        mainAxisSize:MainAxisSize.min ,
                        children: [
                          defaultFormField(
                            controller: titleController,
                            type: TextInputType.text,
                            label: 'task title',
                            prefix: Icons.title,),
                          SizedBox(
                            height: 15.0,
                          ),
                          defaultFormField(
                              controller: timeController,
                              type: TextInputType.datetime,
                              label: 'task time',
                              prefix: Icons.watch_later_outlined,
                              onTap: ()
                              {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value)
                                {
                                  timeController.text = value!.format(context);
                                  print(value.format(context));
                                });
                              }),
                          SizedBox(
                            height: 15.0,
                          ),
                          defaultFormField(
                              controller: dateController,
                              type: TextInputType.datetime,
                              label: 'task date',
                              prefix: Icons.calendar_today,
                              onTap: ()
                              {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse('2021-11-10'),
                                ).then((DateTime ? value)
                                {
                                  dateController.text =DateFormat.yMMMd().format(value!);
                                });
                              }),

                        ],
                      ),
                    ),
                    elevation: 20.0,
                  ).closed.then((value)
                  {
                    cubit.changeBottomSheetState(
                        icon: Icons.edit,
                        isShow: false,
                    );

                  });
                  cubit.changeBottomSheetState(
                      icon: Icons.add,
                      isShow: true,
                  );
                }
              },
              child: Icon(
                cubit.fabIcon,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: cubit.currentIndex,
                onTap: (index)
                {
                  cubit.ChangeIndex(index);
                },
                items:
                [
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.menu,
                      ) ,
                      label: 'Tasks'
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.check_circle_outline,
                      ) ,
                      label: 'Done'
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.archive_outlined,
                      ) ,
                      label: 'Archived'
                  )
                ]
            ),
          );
        },
      ),
    );
  }
  Future<String> getNAme() async
  {
    return 'Ammar Hussein';
  }

}

