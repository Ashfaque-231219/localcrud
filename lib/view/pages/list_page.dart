import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localdbcrud/bloc/user_bloc/user_event.dart';
import 'package:localdbcrud/bloc/user_bloc/user_state.dart';
import 'package:localdbcrud/view/pages/user_data.dart';

import '../../bloc/user_bloc/user_bloc.dart';
import '../shared_widget/EditPopup.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  triggerUserEvent(UserEvent event) {
    context.read<UserBloc>().add(event);
  }

  @override
  initState() {
    super.initState();
    triggerUserEvent(GetUsers(context: context));
    // Add listeners to this class
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Data of the Users"),
            actions: [
              IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => UserData()));
              }, icon: Icon(Icons.add))
            ],
          ),

          body: state.student != null && state.student!.isNotEmpty? ListView.builder(
              shrinkWrap: true,
              itemCount: state.student?.length,
              itemBuilder: (BuildContext context, index) {
                return Card(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0.5, 1),
                          blurRadius: 1,
                          spreadRadius: 1,
                        )
                      ],
                      color: Colors.white,
                    ),
                    width: width,
                    // height: height * 0.13,
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          Container(
                            width: width * 0.01,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(width * 0.008),
                            ),
                            child: Image.file(File(state.student?[index]?.image ?? '')),
                            width: width * 0.23,
                            height: width * 0.23,
                          ),
                          SizedBox(
                            width: width * 0.01,
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${state.student?[index]?.name}'),
                                  SizedBox(height: 8,),
                                  Text('${state.student?[index]?.address}'),
                                  SizedBox(height: 10,),
                                  Text('${state.student?[index]?.contactNo}'),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return EditPopup(
                                      state.student?[index]?.id
                                    );
                                  });
                            },
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Icon(Icons.edit),
                            ),
                          ),
                          SizedBox(width: 15,),
                          GestureDetector(
                            onTap: () async {
                              triggerUserEvent(DeleteStudent(id: state.student?[index]?.id));
                            },
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Icon(Icons.delete),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                );
              }):Center(child: Text('No Record Found'),)
        );
      },
    );
  }
}
