import 'dart:convert';

import 'package:flutter/services.dart';

import '../model/filter.model.dart';

class DataService {
  Future<List<FilterData>> getData() async {
    String res = await rootBundle.loadString('assets/data.json');
    var map = await json.decode(res);

    List<dynamic> data = map['data'];

    List<FilterData> filterData =
        data.map((d) => FilterData.fromJson(d)).toList();

    return filterData;
  }
}
