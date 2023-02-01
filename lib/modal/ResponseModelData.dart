class ResponseModelData {
  int? catid;
  String? categoryName;
  String? imagedata;

  ResponseModelData({
    this.catid,
    this.categoryName,
    this.imagedata,
  });

  ResponseModelData.fromJson(Map<String, dynamic> json) {
    catid = json['catid']?.toInt();
    categoryName = json['category_name']?.toString();
    imagedata = json['imagedata']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['catid'] = catid;
    data['category_name'] = categoryName;
    data['imagedata'] = imagedata;
    return data;
  }
}

class ProductModel {
  String? status;
  String? message;
  List<ResponseModelData?>? data;

  ProductModel({
    this.status,
    this.message,
    this.data,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toString();
    message = json['message']?.toString();
    if (json['data'] != null) {
      final v = json['data'];
      final arr0 = <ResponseModelData>[];
      v.forEach((v) {
        arr0.add(ResponseModelData.fromJson(v));
      });
      this.data = arr0;
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      final v = this.data;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['data'] = arr0;
    }
    return data;
  }
}
