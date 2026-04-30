import 'package:flutter/material.dart';
import 'package:flutter_pjt/providers/trip_provider.dart';
import 'package:flutter_pjt/screens/home/home_drawer_widget.dart';
import 'package:flutter_pjt/screens/home/home_grid_widget.dart';
import 'package:flutter_pjt/screens/home/home_middle_widget.dart';
import 'package:flutter_pjt/screens/home/home_top_widget.dart';
import 'package:provider/provider.dart';

import '../models/trip_destination.dart';
import '../services/shared_preferences.dart';
import '../services/trip_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  bool _isSearching = false;
  final controller = TextEditingController();
  List<String> _searchHistory = []; // 전체 검색 기록을 담을 상태 변수
  final service = TripService();
  List<TripDestination> destinations = [];

  // sharedPreference인스턴스 생성 (상태 초기화 작업할때)
  Future<void> _initHistory() async {
    final history = await PreferenceService.getSearchHistory();
    setState(() {
      _searchHistory = history;
    });
  }

  // 검색어 저장
  Future<bool> _saveSearchTerm(String term) async {
    String trimmedTerm = term.trim();
    if (trimmedTerm.isEmpty) return false; // 비어있어서 저장 안 함

    // 최신순 정렬 및 중복 제거 로직 추가
    setState(() {
      _searchHistory.remove(term);
      _searchHistory.insert(0, term);
    });
    await PreferenceService.setSearchHistory(_searchHistory);
    return true;
  }

  // 검색어 기록 삭제
  Future<void> _deleteSearchTerm(String term) async {
    setState(() {
      _searchHistory.remove(term);
    });
    await PreferenceService.setSearchHistory(_searchHistory);
  }

  @override
  void initState() {
    super.initState();
    _initHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? Autocomplete(
                optionsBuilder: (textEditingValue) async {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<String>.empty();
                  }
                  return _searchHistory.where((option) =>
                      option.toLowerCase().contains(textEditingValue.text.toLowerCase()));
                },
                optionsViewBuilder: (context, onSelected, options) {
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      color: Colors.white,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width, // 화면 너비에 맞게 조절
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: options.length,
                          itemBuilder: (BuildContext context, int index) {
                            final String option = options.elementAt(index);
                            return ListTile(
                              title: Text(option, style: TextStyle(color: Colors.grey,),),
                              leading: Icon(Icons.history, color: Colors.grey,),
                              trailing: IconButton(
                                icon: Icon(Icons.close, size: 18, color: Colors.grey,),
                                onPressed: () async {
                                  await _deleteSearchTerm(option);
                                },
                              ),
                              onTap: () {
                                onSelected(option);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
                onSelected: (String selection) {
                  setState(() {
                    _isSearching = false;
                  });
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('검색어 : $selection')));
                },
                fieldViewBuilder:
                    (context, fieldController, focusNode, onFieldSubmitted) {
                      return TextField(
                        focusNode: focusNode,
                        autofocus: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "검색어를 입력하세요.",
                        ),
                        onChanged: (value) {
                          setState(() {
                            controller.text = value;
                          });
                        },
                        controller: fieldController,
                        onSubmitted: (value) async {
                          bool isSaved = await _saveSearchTerm(value);  // 검색어 공백 검색 분기처리를 위해..
                          // 검색 결과 스낵바
                          if (isSaved) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('검색 완료: ${value.trim()}')),
                            );
                          }
                          // 검색 후 ui
                          onFieldSubmitted();
                          setState(() {
                            _isSearching = false;
                            controller.clear();
                          });
                        },
                      );
                    },
              )
            : Text('Trip App'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  controller.clear();
                }
              });
            },
            icon: Icon(_isSearching ? Icons.clear_outlined : Icons.search),
          ),
          if (!_isSearching)
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      drawer: HomeDrawerWidget(), // 드로어 추가
      body: Column(
        children: [
          HomeTopWidget(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  HomeMiddleWidget(),

                  const SizedBox(height: 16), // SizedBox는 리빌드 될 필요 x

                  //상위 어딘가에 추가된 앱의 상태 데이터 획득..
                  Expanded(
                    child: Consumer<TripProvider>(
                      builder: (context, tripProvider, child) {
                        return HomeGridWidget(tripProvider.destination);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
