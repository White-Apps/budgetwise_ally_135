class WisaallyOtvetModel {
  String? ltb;
  String? ouh;
  String? ver;
  String? ort;

  WisaallyOtvetModel({this.ltb, this.ouh, this.ver, this.ort});

  WisaallyOtvetModel.fromJson(Map<String, dynamic> json) {
    ltb = json['ltb'];
    ouh = json['ouh'];
    ver = json['ver'];
    ort = json['ort'];
  }
}

class WisaallyResponse {
  late bool blvl;
  late WisaallyOtvetModel wisaallyOtvetModel;

  WisaallyResponse({
    required this.blvl,
    required this.wisaallyOtvetModel,
  });

  WisaallyResponse.fromJson(Map<String, dynamic> json) {
    blvl = json['brs_strt'];
    wisaallyOtvetModel = WisaallyOtvetModel.fromJson(json['bk_json']);
  }
}
