import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class GetProductEvent extends ProductEvent {
  final BuildContext? context;

  const GetProductEvent({
    this.context,
  });

  @override
  List<Object?> get props => [];
}
