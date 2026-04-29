import 'package:flutter/material.dart';
import '../models/trip_destination.dart';
import '../services/trip_service.dart';

class TripProvider with ChangeNotifier{
  final List<TripDestination> _destinations = [];

  TripProvider() {
    searchUser();
  }

  // 네트워킹 시도..
  Future<void> searchUser() async {
    print('네트워킹 시도');
    final service = TripService();
    final List<TripDestination> results = await service.getDestination();
    _destinations.clear();
    _destinations.addAll(results);
    notifyListeners();
  }

  List<TripDestination> get destination => _destinations;

  //DetailScreen 에서 자신의 여행지에 대한 데이터 획득을 위해서.
  TripDestination? getDestinationById(int id){
    try{
      return _destinations.firstWhere((destination) => destination.id == id);
    }catch(e){
      return null;
    }
  }
}