import 'dart:io';

import 'package:afisha_market/core/data/source/remote/response/addResponse.dart';
import 'package:flutter/material.dart';

enum Status { initial, loading, success, fail }

@immutable
class CreateState {
  final Status status;
  final List<File> photos;
  final String name;
  final int cost;
  final String desc;
  final int category;
  final int region;
  final String color;
  final String compatibility;
  final CreateResponse createResponse;

  const CreateState(
      {this.status = Status.initial,
      this.photos = const [],
      this.name = '',
      this.cost = 0,
      this.region = 1,
      this.desc = '',
      this.color = '',
      this.category = 8,
      this.compatibility = '',
      required this.createResponse});

  CreateState copyWith(
      {Status? status,
      List<File>? photos,
      String? name,
      int? cost,
      String? desc,
      int? category,
      int? region,
      String? color,
      String? compatibility,
      CreateResponse? createResponse}) {
    return CreateState(
        status: status ?? this.status,
        photos: photos ?? this.photos,
        name: name ?? this.name,
        cost: cost ?? this.cost,
        region: region ?? this.region,
        desc: desc ?? this.desc,
        category: category ?? this.category,
        color: color ?? this.color,
        compatibility: compatibility ?? this.compatibility,
        createResponse: createResponse ?? this.createResponse);
  }
}
