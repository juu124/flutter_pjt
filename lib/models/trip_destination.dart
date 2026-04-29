// 비즈니스 데이터 추상화 클래스
import 'package:json_annotation/json_annotation.dart';

part 'trip_destination.g.dart';

@JsonSerializable()
class TripDestination {
  final int id;
  final String name;
  final String country;
  final String description;
  @JsonKey(name: 'imageUrl')
  final String imagePath;
  final String discount;

  // 생성자
  const TripDestination({
    required this.id,
    required this.name,
    required this.country,
    required this.description,
    required this.imagePath,
    required this.discount,
  });
  factory TripDestination.fromJson(Map<String, dynamic> json) => _$TripDestinationFromJson(json);
  Map<String, dynamic> toJson() => _$TripDestinationToJson(this);
}
