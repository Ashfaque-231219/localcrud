import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localdbcrud/repositories/product_repo.dart';

import '../helper/constants/api_const.dart';
import '../modal/ResponseModelData.dart';

class ProductService implements ProductRepo {
  final Dio dio;

  ProductService({required this.dio});

  @override
  Future getProduct(Map<String, dynamic> req, BuildContext context) async {
    try {
      Response response = await dio.post(ApiConst.getProduct, data: req);
      ProductModel responseModel = ProductModel.fromJson(response.data);
      return responseModel;
    } catch (e) {
      print(e.toString());
    }
  }
}
