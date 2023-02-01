import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localdbcrud/view_model/product_bloc.dart';
import 'package:localdbcrud/view_model/product_event.dart';
import 'package:localdbcrud/view_model/product_state.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  TextEditingController _firesNameController = TextEditingController();
  TextEditingController _passNameController = TextEditingController();

  triggerUserEvent(ProductEvent event) {
    context.read<ProductBloc>().add(event);
  }

  @override
  void initState() {
    super.initState();
    triggerUserEvent(GetProductEvent(context: context));
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Products Details"),
      ),
      body: Column(
        children: [
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              var data = state.responseModel;
              print("The repsonse model is ${data}");
              return Expanded(
                child: ListView.builder(
                    itemCount: data?.data?.length,
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
                                  child: Image.network('https://superadmintest.medrpha.com/allimage/' + '${data?.data![index]?.imagedata}'),
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
                                        Text('${data?.data![index]?.categoryName}'),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              );
            },
          )
        ],
      ),
    );
  }

}
