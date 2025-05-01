class User {
  int? id;
  dynamic deleteAccountReasonId;
  String? mobileNumber;
  String? name;
  String? email;
  bool? isGstAvailable;
  String? gstNumber;
  String? gstAddress;
  String? inviteCode;
  dynamic invitedBy;
  String? deviceId;
  bool? isEmailVerified;
  bool? isNotificationEnabled;
  bool? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  User({
    this.id,
    this.deleteAccountReasonId,
    this.mobileNumber,
    this.name,
    this.email,
    this.isGstAvailable,
    this.gstNumber,
    this.gstAddress,
    this.inviteCode,
    this.invitedBy,
    this.deviceId,
    this.isEmailVerified,
    this.isNotificationEnabled,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    deleteAccountReasonId: json["deleteAccountReasonId"],
    mobileNumber: json["mobileNumber"],
    name: json["name"],
    email: json["email"],
    isGstAvailable: json["isGSTAvailable"],
    gstNumber: json["GSTNumber"],
    gstAddress: json["GSTAddress"],
    inviteCode: json["inviteCode"],
    invitedBy: json["invitedBy"],
    deviceId: json["deviceId"],
    isEmailVerified: json["isEmailVerified"],
    isNotificationEnabled: json["isNotificationEnabled"],
    isActive: json["isActive"],
    createdAt:
        json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt:
        json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    deletedAt: json["deletedAt"] == null ? null : json['deletedAt'],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "deleteAccountReasonId": deleteAccountReasonId,
    "mobileNumber": mobileNumber,
    "name": name,
    "email": email,
    "isGSTAvailable": isGstAvailable,
    "GSTNumber": gstNumber,
    "GSTAddress": gstAddress,
    "inviteCode": inviteCode,
    "invitedBy": invitedBy,
    "deviceId": deviceId,
    "isEmailVerified": isEmailVerified,
    "isNotificationEnabled": isNotificationEnabled,
    "isActive": isActive,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "deletedAt": deletedAt,
  };
}
