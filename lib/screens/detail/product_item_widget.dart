import 'package:flutter/material.dart';

import '../../models/trip_destination.dart';
import '../../models/trip_product.dart';
import 'product_dialog_widget.dart';

class ProductItemWidget extends StatelessWidget {
  TripDestination destination;
  TripProduct product;
  int index; // 리스트에 순번 매기려고 사용
  ProductItemWidget(this.index, this.destination, this.product);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: NetworkImage(destination.imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text('${destination.name} 여행 상품 ${index + 1}'),
      subtitle: Text('${(index + 1)* 100} 만원부터'),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => ProductDialogWidget(destination, product,),
        );
      },
    );
  }
}
