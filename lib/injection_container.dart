import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:localdbcrud/bloc/user_bloc/user_bloc.dart';
import 'package:localdbcrud/database/database.dart';
import 'package:localdbcrud/repositories/product_repo.dart';
import 'package:localdbcrud/serivices/product_service.dart';
import 'package:localdbcrud/view_model/product_bloc.dart';

import 'helper/utils/request_interceptor.dart';

final serviceLocator = GetIt.instance;

Future<void> init(AppDatabase database) async {
  //! blocs\
  serviceLocator.registerFactory(() => ProductBloc(productRepo: serviceLocator()));
  serviceLocator.registerFactory(() => UserBloc(database));

  //! Services
  serviceLocator.registerLazySingleton<ProductRepo>(() => ProductService(dio: serviceLocator()));
  serviceLocator.registerLazySingleton<Dio>(() => DioClient().provideDio());
}
