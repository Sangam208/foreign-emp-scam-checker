import 'dart:convert';

import 'package:foreign_emp_scam_checker/features/checker/domain/entities/agency.dart';

class AgencyModel extends Agency {
  AgencyModel({
    required super.cid,
    required super.agencyName,
    required super.licenseNo,
    required super.address,
    required super.phoneFax,
    required super.emailOrWebsite,
    required super.contactPerson,
    required super.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cid': cid,
      'agencyName': agencyName,
      'licenseNo': licenseNo,
      'address': address,
      'phoneFax': phoneFax,
      'emailOrWebsite': emailOrWebsite,
      'contactPerson': contactPerson,
      'status': status,
    };
  }

  factory AgencyModel.fromMap(Map<String, dynamic> map) {
    return AgencyModel(
      cid: map['_id'] ?? '',
      agencyName: map['company_name'] ?? '',
      licenseNo: map['license_no'] ?? '',
      address: map['address'] ?? '',
      phoneFax: map['phone_fax'] ?? '',
      emailOrWebsite: map['email_website'] ?? '',
      contactPerson: map['contact_person'] ?? '',
      status: map['status'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AgencyModel.fromJson(String source) =>
      AgencyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  AgencyModel copyWith({
    String? cid,
    String? agencyName,
    String? licenseNo,
    String? address,
    String? phoneFax,
    String? emailOrWebsite,
    String? contactPerson,
    String? status,
  }) {
    return AgencyModel(
      cid: cid ?? this.cid,
      agencyName: agencyName ?? this.agencyName,
      licenseNo: licenseNo ?? this.licenseNo,
      address: address ?? this.address,
      phoneFax: phoneFax ?? this.phoneFax,
      emailOrWebsite: emailOrWebsite ?? this.emailOrWebsite,
      contactPerson: contactPerson ?? this.contactPerson,
      status: status ?? this.status,
    );
  }
}
