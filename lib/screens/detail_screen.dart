import 'package:flutter/material.dart';
import 'package:flutter_pjt/screens/detail/news_list_widget.dart';
import 'package:provider/provider.dart';
import '../models/trip_destination.dart';
import '../providers/news_provider.dart';
import './detail/product_list_widget.dart';

class DetailScreen extends StatefulWidget{
  final TripDestination destination;
  DetailScreen(this.destination);

  @override
  State<StatefulWidget> createState() {
    return DetailScreenState();
  }
}

class DetailScreenState extends State<DetailScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;  // tab 화면 조절

  // 최초 상태
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);  //  vsync: this 애니메이션 적용되어야하는 화면이 현재 화면이라는 뜻

    // news 데이터가 앱의 처음부터 피룡한 부분이 아니기 때문에,
    // 실제 그 데이터가 처음 필요한 순간에 networking을 이용해서 데이터를 구축하고자 한다.
    // news 탭에 뿌려질 데이터이다. 하지만, news 탭이 초기 보이는 탭이 아니다. 미리 데이터를 불러올 필요가 없다.
    // 실제 news 탭이 클릭되는 순간.. 네트워킹에 의해 데이터가 준비되게 하고 싶다.
    tabController.addListener(() {
      // 유저가 탭 버튼을 눌렀을 때 이벤트
      // tabController.indexIsChangin : 뉴스탭이 새로 클릭되어 오픈되는 순간..
      // 뉴스탭이 오픈된 순간.. 다시 유저가 뉴스탭을 또 누르는 순간은 제외..
      if(tabController.index == 1 && tabController.indexIsChanging) {
        final newsProvider = Provider.of<NewsProvider>(context, listen: false);
        // provider 에 데이터가 없는 순간에만..
        if(newsProvider.destinationName != widget.destination.name) {
          newsProvider.fetchNews(widget.destination.name);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.destination.name),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        bottom: TabBar(
          controller: tabController,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue,
          tabs: [
            Tab(text: '상품',),
            Tab(text: '뉴스',)
          ],
        ),
      ),
      body: TabBarView(
          controller: tabController,
        children: [
          ProductListWidget(widget.destination),
          NewsListWidget(widget.destination.name),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }
}