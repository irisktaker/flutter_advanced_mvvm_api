// ! important note
//***
//  - any response call from api's we must expect it's will return a null value | add ? null operator
// */

import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';

@JsonSerializable() //! this package response on creating fromJson and toJson
class BaseResponse {
  @JsonKey(name: "status") // this name must be as in the server name
  int? status;
  @JsonKey(name: "message")
  String? message;
}

@JsonSerializable() 
class CustomerResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "numOfNotifications")
  int? numOfNotifications;
  CustomerResponse(this.id, this.name, this.numOfNotifications);

  // fromJson
  factory CustomerResponse.fromJson(Map<String, dynamic> json) => _$CustomerResponseFromJson(json);
  // toJson
  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactsResponse {
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "link")
  String? link;
  ContactsResponse(this.phone, this.email, this.link);

  // fromJson
  factory ContactsResponse.fromJson(Map<String, dynamic> json) => _$ContactsResponseFromJson(json);
  // toJson
  Map<String, dynamic> toJson() => _$ContactsResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: "customer")
  CustomerResponse? customer;
  @JsonKey(name: "contacts")
  ContactsResponse? contacts;
  AuthenticationResponse(this.customer, this.contacts);

  // fromJson ( Authentication Response )
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) => _$AuthenticationResponseFromJson(json);
  // toJson
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this); // this returns to AuthenticationResponse
}