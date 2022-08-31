import 'package:advanced_flutter/app/constants.dart';
import 'package:advanced_flutter/data/response/responses.dart';
import 'package:advanced_flutter/domain/models.dart';

import 'package:advanced_flutter/app/extensions.dart';

extension CustomerResponseMapper on CustomerResponse? 
{
  Customer toDomain() => Customer(this?.id.orEmpty()??Constants.empty, this?.name.orEmpty()??Constants.empty, this?.numOfNotifications.orZero()??Constants.zero);
}

extension ContactsResponseMapper on ContactsResponse? 
{
  Contacts toDomain() => Contacts(this?.phone.orEmpty()??Constants.empty, this?.email.orEmpty()??Constants.empty, this?.link.orEmpty()??Constants.empty);
}

extension AuthenticationResponseMapper on AuthenticationResponse? 
{
  Authentication toDomain() => Authentication(this?.customer.toDomain(), this?.contacts.toDomain());
}
