final String tableBirthdayInfo = "birthdayinformation";

class BirthdayInfoFields {
  static final List<String> values = [
    id,
    name,
    phoneNo,
    dateofbirth,
  ];
  static final String id = "_id";
  static final String name = "name";
  static final String phoneNo = "phone_no";
  static final String dateofbirth = "dateofbirth";
}

class BirthdayInfo {
  final int? id;
  final String name;
  final int? phoneNo;
  final DateTime dateofbirth;

  const BirthdayInfo({
    this.id,
    required this.name,
    this.phoneNo,
    required this.dateofbirth,
  });

  BirthdayInfo copy({
    int? id,
    String? name,
    int? phoneNo,
    DateTime? dateofbirth,
  }) =>
      BirthdayInfo(
        id: id ?? this.id,
        name: name ?? this.name,
        phoneNo: phoneNo ?? this.phoneNo,
        dateofbirth: dateofbirth ?? this.dateofbirth,
      );

  static BirthdayInfo fromJson(Map<String, Object?> json) => BirthdayInfo(
        id: json[BirthdayInfoFields.id] as int?,
        name: json[BirthdayInfoFields.name] as String,
        phoneNo: json[BirthdayInfoFields.phoneNo] as int?,
        dateofbirth:
            DateTime.parse(json[BirthdayInfoFields.dateofbirth] as String),
      );

  Map<String, Object?> toJson() => {
        BirthdayInfoFields.id: id,
        BirthdayInfoFields.name: name,
        BirthdayInfoFields.phoneNo: phoneNo,
        BirthdayInfoFields.dateofbirth: dateofbirth.toIso8601String(),
      };
}
