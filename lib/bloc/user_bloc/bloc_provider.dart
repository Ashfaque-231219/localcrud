/* ************************************************************************
* Directory Name: splash_bloc                                             *
* File Name: bloc_provider.dart                                           *
* Created At: Saturday, 19th March 2022 7:48:17 pm                        *
* Created By: singsys (Harshit Kishor)                                    *
************************************************************************ */
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localdbcrud/bloc/user_bloc/user_bloc.dart';
import 'package:localdbcrud/injection_container.dart' as di;
import 'package:localdbcrud/view_model/product_bloc.dart';

class MyBlocProvider extends StatelessWidget {
  final Widget child;

  const MyBlocProvider({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(create: (context) => di.serviceLocator<ProductBloc>()),
        BlocProvider<UserBloc>(create: (context) => di.serviceLocator<UserBloc>()),
      ],
      child: child,
    );
  }
}
