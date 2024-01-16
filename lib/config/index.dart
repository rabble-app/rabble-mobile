// Necessary because Dart isn't very good with dynamically typed constructors
// https://stackoverflow.com/questions/55237006/how-to-call-a-named-constructor-from-a-generic-function-in-dart-flutter
// ONLY enter those that can be returned from API endpoints

import 'package:rabble/config/export.dart';
import 'package:rabble/domain/entities/ApplyPayModel.dart';
import 'package:rabble/domain/entities/PartionedProductsData.dart';
import 'package:rabble/domain/entities/MoreProductModel.dart';
import 'package:rabble/domain/entities/ProfilePictureModel.dart';
import 'package:rabble/domain/entities/RequestModel.dart';
import 'package:rabble/domain/entities/RequestSendModel.dart';
import 'package:rabble/domain/entities/TeamCountModel.dart';
import 'package:rabble/domain/entities/TeamDetailChatModel.dart';
import 'package:rabble/domain/entities/UserBasketModel.dart';
import 'package:rabble/domain/entities/UserTeamModel.dart';

import '../domain/entities/MySubscriptionModel.dart';

final dataFactories = {
  Null: (_) => null,
  BaseModel: (_) => BaseModel.fromJson(_),
  UserModel: (_) => UserModel.fromJson(_),
  ProducerModel: (_) => ProducerModel.fromJson(_),
  BuyingTeamModel: (_) => BuyingTeamModel.fromJson(_),
  ProductModel: (_) => ProductModel.fromJson(_),
  CardModel: (_) => CardModel.fromJson(_),
  CustomerAddress: (_) => CustomerAddress.fromJson(_),
  ChargeModel: (_) => ChargeModel.fromJson(_),
  TeamCreationModel: (_) => TeamCreationModel.fromJson(_),
  BulkUploadedModel: (_) => BulkUploadedModel.fromJson(_),
  TeamModel: (_) => TeamModel.fromJson(_),
  OrderModel: (_) => OrderModel.fromJson(_),
  NotificationModel: (_) => NotificationModel.fromJson(_),
  OrderHistoryModel: (_) => OrderHistoryModel.fromJson(_),
  UserTeamModel: (_) => UserTeamModel.fromJson(_),
  RequestModel: (_) => RequestModel.fromJson(_),
  SearchProductModel: (_) => SearchProductModel.fromJson(_),
  InvitationModel: (_) => InvitationModel.fromJson(_),
  AddTeamMemberModel: (_) => AddTeamMemberModel.fromJson(_),
  ProfilePictureModel: (_) => ProfilePictureModel.fromJson(_),
  ApplyPayModel: (_) => ApplyPayModel.fromJson(_),
  PaymentIntentModel: (_) => PaymentIntentModel.fromJson(_),
  Count: (_) => Count.fromJson(_),
  PopularSearchModel: (_) => PopularSearchModel.fromJson(_),
  RecentSearchModel: (_) => RecentSearchModel.fromJson(_),
  UserBasketModel: (_) => UserBasketModel.fromJson(_),
  MoreProductModel: (_) => MoreProductModel.fromJson(_),
  RequestSendModel: (_) => RequestSendModel.fromJson(_),
  PartionedProducts: (_) => PartionedProducts.fromJson(_),
  MySubscriptionModel: (_) => MySubscriptionModel.fromJson(_),
  CheckModel: (_) => CheckModel.fromJson(_),
  ProductDetailModel: (_) => ProductDetailModel.fromJson(_),
  DeadlineModel: (_) => DeadlineModel.fromJson(_),
  TeamExistModel: (_) => TeamExistModel.fromJson(_),
  TeamChatListModel: (_) => TeamChatListModel.fromJson(_),
  TeamDetailChatModel: (_) => TeamDetailChatModel.fromJson(_),

};
