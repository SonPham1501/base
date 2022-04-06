class ProvinceModel {
  String? id;
  String? countryId;
  String? name;
  String? abbreviation;
  String? published;
  String? displayOrder;
  String? companyId;
  String? subjectToAcl;
  String? displayName;

  ProvinceModel(
      {this.id,
      this.countryId,
      this.name,
      this.abbreviation,
      this.published,
      this.displayOrder,
      this.companyId,
      this.subjectToAcl,
      this.displayName});

  ProvinceModel.fromJson(dynamic json) {
    id = json["Id"];
    countryId = json["CountryId"];
    name = json["Name"];
    abbreviation = json["Abbreviation"];
    published = json["Published"];
    displayOrder = json["DisplayOrder"];
    companyId = json["CompanyId"];
    subjectToAcl = json["SubjectToAcl"];
    displayName = json["DisplayName"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["Id"] = id;
    map["CountryId"] = countryId;
    map["Name"] = name;
    map["Abbreviation"] = abbreviation;
    map["Published"] = published;
    map["DisplayOrder"] = displayOrder;
    map["CompanyId"] = companyId;
    map["SubjectToAcl"] = subjectToAcl;
    map["DisplayName"] = displayName;
    return map;
  }

  static List<ProvinceModel> getData() {
    var list = <ProvinceModel>[];
    var listMap = [
      {
        "Id": "1351",
        "CountryId": "230",
        "Name": "Hà Nội",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Thành phố Hà Nội"
      },
      {
        "Id": "1352",
        "CountryId": "230",
        "Name": "Hà Giang",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Hà Giang"
      },
      {
        "Id": "1353",
        "CountryId": "230",
        "Name": "Cao Bằng",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Cao Bằng"
      },
      {
        "Id": "1354",
        "CountryId": "230",
        "Name": "Bắc Kạn",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Bắc Kạn"
      },
      {
        "Id": "1355",
        "CountryId": "230",
        "Name": "Tuyên Quang",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Tuyên Quang"
      },
      {
        "Id": "1356",
        "CountryId": "230",
        "Name": "Lào Cai",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Lào Cai"
      },
      {
        "Id": "1357",
        "CountryId": "230",
        "Name": "Điện Biên",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Điện Biên"
      },
      {
        "Id": "1358",
        "CountryId": "230",
        "Name": "Lai Châu",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Lai Châu"
      },
      {
        "Id": "1359",
        "CountryId": "230",
        "Name": "Sơn La",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Sơn La"
      },
      {
        "Id": "1360",
        "CountryId": "230",
        "Name": "Yên Bái",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Yên Bái"
      },
      {
        "Id": "1361",
        "CountryId": "230",
        "Name": "Hoà Bình",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Hoà Bình"
      },
      {
        "Id": "1362",
        "CountryId": "230",
        "Name": "Thái Nguyên",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Thái Nguyên"
      },
      {
        "Id": "1363",
        "CountryId": "230",
        "Name": "Lạng Sơn",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Lạng Sơn"
      },
      {
        "Id": "1364",
        "CountryId": "230",
        "Name": "Quảng Ninh",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Quảng Ninh"
      },
      {
        "Id": "1365",
        "CountryId": "230",
        "Name": "Bắc Giang",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Bắc Giang"
      },
      {
        "Id": "1366",
        "CountryId": "230",
        "Name": "Phú Thọ",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Phú Thọ"
      },
      {
        "Id": "1367",
        "CountryId": "230",
        "Name": "Vĩnh Phúc",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Vĩnh Phúc"
      },
      {
        "Id": "1368",
        "CountryId": "230",
        "Name": "Bắc Ninh",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Bắc Ninh"
      },
      {
        "Id": "1369",
        "CountryId": "230",
        "Name": "Hải Dương",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Hải Dương"
      },
      {
        "Id": "1370",
        "CountryId": "230",
        "Name": "Hải Phòng",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Thành phố Hải Phòng"
      },
      {
        "Id": "1371",
        "CountryId": "230",
        "Name": "Hưng Yên",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Hưng Yên"
      },
      {
        "Id": "1372",
        "CountryId": "230",
        "Name": "Thái Bình",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Thái Bình"
      },
      {
        "Id": "1373",
        "CountryId": "230",
        "Name": "Hà Nam",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Hà Nam"
      },
      {
        "Id": "1374",
        "CountryId": "230",
        "Name": "Nam Định",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Nam Định"
      },
      {
        "Id": "1375",
        "CountryId": "230",
        "Name": "Ninh Bình",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Ninh Bình"
      },
      {
        "Id": "1376",
        "CountryId": "230",
        "Name": "Thanh Hóa",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Thanh Hóa"
      },
      {
        "Id": "1377",
        "CountryId": "230",
        "Name": "Nghệ An",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Nghệ An"
      },
      {
        "Id": "1378",
        "CountryId": "230",
        "Name": "Hà Tĩnh",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Hà Tĩnh"
      },
      {
        "Id": "1379",
        "CountryId": "230",
        "Name": "Quảng Bình",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Quảng Bình"
      },
      {
        "Id": "1380",
        "CountryId": "230",
        "Name": "Quảng Trị",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Quảng Trị"
      },
      {
        "Id": "1381",
        "CountryId": "230",
        "Name": "Thừa Thiên Huế",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Thừa Thiên Huế"
      },
      {
        "Id": "1382",
        "CountryId": "230",
        "Name": "Đà Nẵng",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Thành phố Đà Nẵng"
      },
      {
        "Id": "1383",
        "CountryId": "230",
        "Name": "Quảng Nam",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Quảng Nam"
      },
      {
        "Id": "1384",
        "CountryId": "230",
        "Name": "Quảng Ngãi",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Quảng Ngãi"
      },
      {
        "Id": "1385",
        "CountryId": "230",
        "Name": "Bình Định",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Bình Định"
      },
      {
        "Id": "1386",
        "CountryId": "230",
        "Name": "Phú Yên",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Phú Yên"
      },
      {
        "Id": "1387",
        "CountryId": "230",
        "Name": "Khánh Hòa",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Khánh Hòa"
      },
      {
        "Id": "1388",
        "CountryId": "230",
        "Name": "Ninh Thuận",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Ninh Thuận"
      },
      {
        "Id": "1389",
        "CountryId": "230",
        "Name": "Bình Thuận",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Bình Thuận"
      },
      {
        "Id": "1390",
        "CountryId": "230",
        "Name": "Kon Tum",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Kon Tum"
      },
      {
        "Id": "1391",
        "CountryId": "230",
        "Name": "Gia Lai",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Gia Lai"
      },
      {
        "Id": "1392",
        "CountryId": "230",
        "Name": "Đắk Lắk",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Đắk Lắk"
      },
      {
        "Id": "1393",
        "CountryId": "230",
        "Name": "Đắk Nông",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Đắk Nông"
      },
      {
        "Id": "1394",
        "CountryId": "230",
        "Name": "Lâm Đồng",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Lâm Đồng"
      },
      {
        "Id": "1395",
        "CountryId": "230",
        "Name": "Bình Phước",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Bình Phước"
      },
      {
        "Id": "1396",
        "CountryId": "230",
        "Name": "Tây Ninh",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Tây Ninh"
      },
      {
        "Id": "1397",
        "CountryId": "230",
        "Name": "Bình Dương",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Bình Dương"
      },
      {
        "Id": "1398",
        "CountryId": "230",
        "Name": "Đồng Nai",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Đồng Nai"
      },
      {
        "Id": "1399",
        "CountryId": "230",
        "Name": "Bà Rịa - Vũng Tàu",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Bà Rịa - Vũng Tàu"
      },
      {
        "Id": "1400",
        "CountryId": "230",
        "Name": "Hồ Chí Minh",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Thành phố Hồ Chí Minh"
      },
      {
        "Id": "1401",
        "CountryId": "230",
        "Name": "Long An",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Long An"
      },
      {
        "Id": "1402",
        "CountryId": "230",
        "Name": "Tiền Giang",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Tiền Giang"
      },
      {
        "Id": "1403",
        "CountryId": "230",
        "Name": "Bến Tre",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Bến Tre"
      },
      {
        "Id": "1404",
        "CountryId": "230",
        "Name": "Trà Vinh",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Trà Vinh"
      },
      {
        "Id": "1405",
        "CountryId": "230",
        "Name": "Vĩnh Long",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Vĩnh Long"
      },
      {
        "Id": "1406",
        "CountryId": "230",
        "Name": "Đồng Tháp",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Đồng Tháp"
      },
      {
        "Id": "1407",
        "CountryId": "230",
        "Name": "An Giang",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh An Giang"
      },
      {
        "Id": "1408",
        "CountryId": "230",
        "Name": "Kiên Giang",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Kiên Giang"
      },
      {
        "Id": "1409",
        "CountryId": "230",
        "Name": "Cần Thơ",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Thành phố Cần Thơ"
      },
      {
        "Id": "1410",
        "CountryId": "230",
        "Name": "Hậu Giang",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Hậu Giang"
      },
      {
        "Id": "1411",
        "CountryId": "230",
        "Name": "Sóc Trăng",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Sóc Trăng"
      },
      {
        "Id": "1412",
        "CountryId": "230",
        "Name": "Bạc Liêu",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Bạc Liêu"
      },
      {
        "Id": "1413",
        "CountryId": "230",
        "Name": "Cà Mau",
        "Abbreviation": "",
        "Published": "t",
        "DisplayOrder": "1",
        "CompanyId": "",
        "SubjectToAcl": "",
        "DisplayName": "Tỉnh Cà Mau"
      }
    ];
    for (var item in listMap) {
      list.add(ProvinceModel.fromJson(item));
    }
    return list;
  }
}
