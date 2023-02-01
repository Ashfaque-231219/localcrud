import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localdbcrud/bloc/bloc_delegate.dart';
import 'package:localdbcrud/bloc/user_bloc/bloc_provider.dart';
import 'package:localdbcrud/injection_container.dart' as di;
import 'package:localdbcrud/view/pages/googlelocation.dart';
import 'package:localdbcrud/view/pages/news_page.dart';
import 'package:localdbcrud/view/pages/socal_login_page.dart';

import 'database/database.dart';
import 'firebase_options.dart';

globalInitilizer() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await $FloorAppDatabase.databaseBuilder('my_db.db').build();
  print(database);

  await di.init(database);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await globalInitilizer();
  BlocOverrides.runZoned(() => runApp(MyApp()), blocObserver: SimpleBlocObserver());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyBlocProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:  NewsPage(),
      ),
    );
  }
}
