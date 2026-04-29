import 'package:dio/dio.dart';
import 'package:flutter_pjt/models/trip_destination.dart';

class TripService {
  late final Dio _dio;

  TripService() {
    _dio = Dio(BaseOptions(
      baseUrl: 'http://10.0.2.2:3000',
      connectTimeout: 5000,
      receiveTimeout: 3000,
    ));
    _dio.interceptors.add(LogInterceptor());
  }

  Future<List<TripDestination>> getDestination() async {
    // final response = await _dio.get('/destinations/$id');
    final response = await _dio.get('/destinations');
    final List<dynamic> data = response.data;
    return data.map((e) => TripDestination.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<TripDestination?> getDestinationById(int id) async {
    try {
      // 서버의 '/destinations/:id' 경로로 GET 요청
      final response = await _dio.get('/destinations/$id');

      if (response.statusCode == 200) {
        return TripDestination.fromJson(response.data as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      // 404 Not Found 등 에러 발생 시 처리
      print('Error fetching destination: $e');
      return null;
    }
  }
}