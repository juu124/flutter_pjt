import 'package:flutter/material.dart';
import 'product_item_widget.dart';
import '../../models/trip_destination.dart';

class ProductListWidget extends StatelessWidget {
  TripDestination destination;

  ProductListWidget(this.destination);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(destination.imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16), // SizedBox는 리빌드 될 필요 x
          Text(
            destination.description,
            style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onSurface),
          ),
          const SizedBox(height: 24), // SizedBox는 리빌드 될 필요 x
          Text(
            '추천 상품',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16), // SizedBox는 리빌드 될 필요 x
          // 목록 화면 구성하기
          ListView.builder(
            // 자신의 컨텐츠 사이즈 정도만 화면을 차기하게 한다.
            shrinkWrap: true,
            // NeverScrollableScrollPhysics : ListView는 자체 스크롤을 지원한다. 하지만, 나는 화면 전체를 스크롤되는걸로 하고 싶어.
            // 화면 전체 스크롤에 따라라
            physics: NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.only(bottom: 12),
                child: ProductItemWidget( index, destination),
              );
            }
          )
        ],
      ),
    );
  }
}
