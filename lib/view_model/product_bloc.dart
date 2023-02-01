import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localdbcrud/modal/ResponseModelData.dart';
import 'package:localdbcrud/repositories/product_repo.dart';
import 'package:localdbcrud/view_model/product_event.dart';
import 'package:localdbcrud/view_model/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductRepo productRepo;
  Dio? dio;

  ProductBloc({
    required this.productRepo,
    this.dio,
  }) : super(ProductState()) {
    on<GetProductEvent>((
      event,
      emit,
    ) async {
      await _getProductEvent(
        event,
        emit,
      );
    });
  }

  _getProductEvent(GetProductEvent event, Emitter<ProductState> emit) async {
    // emit(state.copyWith(stateStatus: StateLoading()));
    try {
      Map<String, dynamic> req = {};
      req['sessid'] = 'a3312094d9c3b56f';
      ProductModel productModel = await productRepo.getProduct(req, event.context!);
      if(productModel.message == "successful !!"){
        emit(state.copyWith(responseModel: productModel));

      }
    } catch (e) {
      print(e.toString());
    }
  }
}
