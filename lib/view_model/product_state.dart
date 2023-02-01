import 'package:localdbcrud/modal/ResponseModelData.dart';

class ProductState {
  final ProductModel? responseModel;

  ProductState({this.responseModel});

  ProductState copyWith({
    final ProductModel? responseModel,
  }) {
    return ProductState(
      responseModel: responseModel ?? this.responseModel,
    );
  }

  @override
  String toString() {
    return "ProductState{responseModel:$responseModel}";
  }
}
