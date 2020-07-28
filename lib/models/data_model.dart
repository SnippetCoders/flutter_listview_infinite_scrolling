class DataModel {
  int totalRecords;
  List<Radio> data;

  DataModel({
    this.totalRecords,
    this.data,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      totalRecords: int.parse(json['Message']),
      data: (json["Data"] as List).map((i) => Radio.fromJson(i)).toList()
    );
  }
}

class Radio {
  final int id;
  final String radioName;

  Radio({
    this.id,
    this.radioName,
  });

  factory Radio.fromJson(Map<String, dynamic> json) {
    return Radio(
      id: json["ID"],
      radioName: json['RadioName'],
    );
  }
}
