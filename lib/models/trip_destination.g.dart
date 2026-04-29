// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_destination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripDestination _$TripDestinationFromJson(Map<String, dynamic> json) =>
    TripDestination(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      country: json['country'] as String,
      description: json['description'] as String,
      imagePath: json['imageUrl'] as String,
      discount: json['discount'] as String,
    );

Map<String, dynamic> _$TripDestinationToJson(TripDestination instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'country': instance.country,
      'description': instance.description,
      'imageUrl': instance.imagePath,
      'discount': instance.discount,
    };
