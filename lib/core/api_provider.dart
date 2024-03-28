import 'package:http/http.dart' as http;
import 'package:rabble/core/config/export.dart';
import 'package:rabble/domain/entities/BulkUploadedModel.dart';
import 'package:rabble/domain/entities/CardModel.dart';
import 'package:rabble/domain/entities/ChargeModel.dart';
import 'package:rabble/domain/entities/ConversationModel.dart';
import 'package:rabble/domain/entities/MoreProductModel.dart';
import 'package:rabble/domain/entities/ProfilePictureModel.dart';
import 'package:rabble/domain/entities/RequestSendModel.dart';
import 'package:rabble/domain/entities/TeamCreationModel.dart';
import 'package:rabble/domain/entities/TeamDetailChatModel.dart';
import 'package:rabble/domain/entities/TeamModel.dart';
import 'package:rabble/domain/entities/UserBasketModel.dart';
import 'package:rabble/domain/entities/UserTeamModel.dart';
import 'dart:math' as math; // Import the math library

import '../domain/entities/MySubscriptionModel.dart';

class ApiProvider extends Source {
  ApiProvider() : super(methodName: '');
  final client = http.Client();

  Future<BaseModel> login(
    String phone, {
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {
    final res = await post<BaseModel>(constructUrl('$nAuth$nSendOtp'),
        body: {pPhone: phone},
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<BaseModel> sendMessage(
    String teamId,
    String producerId,
    String message, {
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {
    final res = await post<BaseModel>(constructUrl('chats'),
        body: {'teamId': teamId, 'producerId': producerId, 'text': message},
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<BaseModel> connectionPusher(
    String socketId, {
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {
    final res = await post<BaseModel>(constructUrl('auth/pusher-user'),
        body: {'socket_id': socketId},
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<ConversationModel> chatList(
    String teamId,
    String offset, {
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {
    final res = await get<ConversationModel>(
        constructUrl('chats?teamId=$teamId&offset=$offset'),
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<TeamChatListModel> fetchTeamChatList({
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {
    final res = await get<TeamChatListModel>(constructUrl('chats/teams'),
        throwOnError: throwOnError, snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<TeamDetailChatModel> fetchTeamDetail(
    String teamId, {
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {
    final res = await get<TeamDetailChatModel>(
        constructUrl('teams/$teamId?trim=true'),
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<InvitationModel> verifyToken(String token,
      {throwOnError = true,
      snackBarOnError = true,
      VoidCallback? errorCallBack,
      Function? retryCallBack}) async {
    final res = await post<InvitationModel>(
        constructUrl('$nTeams/verify-invite'),
        body: {'token': token},
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError,
        retryCallBack: retryCallBack,
        errorCallBack: errorCallBack);

    return res!.data;
  }

  Future<BaseModel> verifyOtp(
    String phone,
    String code,
    String sid, {
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {
    String? token = await FirebaseMessagingManager().getToken();

    Map<String, String> body = {
      pPhone: phone,
      pCode: code,
      pSid: sid,
      pFirebasetoken: token ?? ''
    };
    final res = await post<BaseModel>(constructUrl('$nAuth$nVerifyOtp'),
        body: body,
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<BaseModel> updateProfileData({
    throwOnError = true,
    snackBarOnError = true,
    Map<String, String>? body,
    VoidCallback? errorCallBack,
  }) async {
    final res = await patch<BaseModel>(constructUrl('$nUser$nUpdate'),
        body: body!,
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<ProfilePictureModel> updateProfilePhoto({
    throwOnError = true,
    snackBarOnError = true,
    FormData? body,
    VoidCallback? errorCallBack,
  }) async {
    final res = await post<ProfilePictureModel>(constructUrl('$nUploadProfile'),
        data: body!,
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<BaseModel> addNewAddress({
    throwOnError = true,
    snackBarOnError = true,
    Map<String, String>? body,
    VoidCallback? errorCallBack,
  }) async {
    final res = await post<BaseModel>(constructUrl('$nUser$nDelvieryAddress'),
        body: body!,
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<BaseModel> inviteContacts({
    throwOnError = true,
    snackBarOnError = true,
    Map<String, dynamic>? body,
    VoidCallback? errorCallBack,
  }) async {
    final res = await post<BaseModel>(constructUrl('$nTeams/$nBulkInvite'),
        body: body!,
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<BaseModel> addToTeam({
    throwOnError = true,
    snackBarOnError = true,
    Map<String, dynamic>? body,
    VoidCallback? errorCallBack,
  }) async {
    final res = await post<BaseModel>(constructUrl('$nTeams/join'),
        body: body!,
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<AddTeamMemberModel> addMemeber({
    throwOnError = true,
    snackBarOnError = true,
    Map<String, dynamic>? body,
    VoidCallback? errorCallBack,
  }) async {
    final res = await post<AddTeamMemberModel>(
        constructUrl('$nTeams/add-member'),
        body: body!,
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<BaseModel> updateTeam({
    throwOnError = true,
    snackBarOnError = true,
    Map<String, dynamic>? body,
    VoidCallback? errorCallBack,
  }) async {
    final res = await patch<BaseModel>(constructUrl('$nTeams/request/$nUpdate'),
        body: body!,
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<BaseModel> updateTeamData(
    String id, {
    throwOnError = true,
    snackBarOnError = true,
    Map<String, dynamic>? body,
    VoidCallback? errorCallBack,
  }) async {
    final res = await patch<BaseModel>(constructUrl('$nTeams/$id'),
        body: body!,
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError,
        errorCallBack: errorCallBack);

    return res!.data;
  }

  Future<BaseModel> skipNextDeliver({
    throwOnError = true,
    snackBarOnError = true,
    String? id,
    VoidCallback? errorCallBack,
  }) async {
    final res = await get<BaseModel>(
        constructUrl('$nTeams/members/skip-delivery/$id'),
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<BaseModel> quiteTeam({
    throwOnError = true,
    snackBarOnError = true,
    String? id,
    VoidCallback? errorCallBack,
  }) async {
    final res = await delete<BaseModel>(constructUrl('$nTeams/quit/$id'),
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError,
        errorCallBack: errorCallBack);

    return res!.data;
  }

  Future<BaseModel> deleteMyAccount({
    throwOnError = true,
    snackBarOnError = true,
    String? id,
    VoidCallback? errorCallBack,
  }) async {
    final res = await delete<BaseModel>(constructUrl('auth/quit/$id'),
        throwOnError: throwOnError, snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<BaseModel> requestToJoinTeam({
    throwOnError = true,
    snackBarOnError = true,
    Map<String, dynamic>? body,
    VoidCallback? errorCallBack,
  }) async {
    final res = await post<BaseModel>(constructUrl('$nTeams/join'),
        body: body,
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<BaseModel> nudgeTeamMember({
    throwOnError = true,
    snackBarOnError = true,
    Map<String, dynamic>? body,
    VoidCallback? errorCallBack,
  }) async {
    final res = await post<BaseModel>(constructUrl('$nTeams/nudge'),
        body: body,
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<BaseModel> nudgeTeam({
    throwOnError = true,
    snackBarOnError = true,
    String? teamId,
    VoidCallback? errorCallBack,
  }) async {
    final res = await post<BaseModel>(constructUrl('$nTeams/nudge/$teamId'),
        throwOnError: throwOnError, snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<BaseModel> updateAddress({
    throwOnError = true,
    snackBarOnError = true,
    Map<String, String>? body,
    String? userId,
    VoidCallback? errorCallBack,
  }) async {
    final res = await patch<BaseModel>(
        constructUrl('$nUser$nDelvieryAddress/$userId'),
        body: body!,
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<BaseModel> updatePostalCode(
    String phone,
    String postalCode, {
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {
    Map<String, String> body = {pPhone: phone, pPostalCode: postalCode};
    final res = await patch<BaseModel>(constructUrl('$nUser$nUpdate'),
        body: body,
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<ProductModel> fetchProducerProductList(
    String id, {
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {
    final res = await get<ProductModel>(
        constructUrl('$nProducts/$nProducer/$id'),
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<ProductModel> fetchProducerProductListForTeam(
    String producerId,
    String teamId, {
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {
    final res = await get<ProductModel>(
        constructUrl('$nProducts/$nProducer/$producerId?teamId=$teamId'),
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<BaseModel> fetchProducerDetail(
    String producerId, {
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {
    final res = await get<BaseModel>(
        constructUrl('$nUser$nProducer/$producerId'),
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<MoreProductModel> fetchMoreProductList(
    String id, {
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {
    final res = await get<MoreProductModel>(
        constructUrl('$nProducts/also-bought/$id'),
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<ProductDetailModel> fetchProductDetail(
    String id, {
    String? teamId,
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {
    String url = teamId != null && teamId.isNotEmpty
        ? '$nProducts/$id?teamId=$teamId'
        : '$nProducts/$id';

    final res = await get<ProductDetailModel>(constructUrl(url),
        throwOnError: throwOnError, snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<ProducerModel> fetchProducerList(
    int offset, {
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {
    final res = await get<ProducerModel>(
        constructUrl('${nUser}producers?offset=$offset'),
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError,
        errorCallBack: errorCallBack);

    return res!.data;
  }

  Future<ProducerModel> fetchMyProducerList(
    String id, {
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {
    final res = await get<ProducerModel>(constructUrl('$nUser$nProducerOffset'),
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError,
        errorCallBack: errorCallBack);

    return res!.data;
  }

  Future<BuyingTeamModel> fetchBuyingTeamList(
    String postalCode, {
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {
    final res = await get<BuyingTeamModel>(
        constructUrl('$nTeams/$pPostalCode/$postalCode'),
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<UserTeamModel> fetchMembersTeam(
    String id, {
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {
    final res = await get<UserTeamModel>(constructUrl('$nTeams/user/$id'),
        throwOnError: throwOnError, snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<BuyingTeamModel> fetchHostTeam(
    String id, {
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {
    final res = await get<BuyingTeamModel>(constructUrl('users/my-teams/$id'),
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError,
        errorCallBack: errorCallBack);

    return res!.data;
  }

  Future<BuyingTeamModel> fetchAllTeams({
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {
    final res = await get<BuyingTeamModel>(constructUrl(nTeams),
        throwOnError: throwOnError, snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<BuyingTeamModel> fetchAllBuyingTeamsForPostalCode(
    int offset,
    String postalCode, {
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {
    final res = await get<BuyingTeamModel>(
        constructUrl(
            '$nTeams/postalcode/$postalCode?offset=${offset.toString()}'),
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<BuyingTeamModel> fetchAllMyTeams(
    String id, {
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {
    final res = await get<BuyingTeamModel>(
        constructUrl('$nTeams/$nProducer/$id'),
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<MySubscriptionModel> fetchMySubscribtion(
    String id, {
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {
    final res = await get<MySubscriptionModel>(
        constructUrl('${nUser}subscription/$id'),
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<CheckModel> checkTeamNameExist(
    String name, {
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {
    final res = await post<CheckModel>(constructUrl('teams/check-name/$name'),
        throwOnError: throwOnError, snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<BuyingTeamModel> checkTeamExist(
    String producerId,
    String postalCode, {
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {
    final res = await get<BuyingTeamModel>(
        constructUrl('teams/check-producer-group/$producerId/$postalCode'),
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<TeamModel> fetchBuyingTeamDetail(
    String teamId, {
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {
    final res = await get<TeamModel>(constructUrl('$nTeams/$teamId'),
        throwOnError: throwOnError, snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<OrderModel> fetchCurrentOrderDetail(
    String teamId, {
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {
    final res = await get<OrderModel>(
        constructUrl('$nTeams/$nCurrentOrder/$teamId'),
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<SearchProductModel> searchProduct(
    String query,
    String type, {
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {
    final res = await get<SearchProductModel>(
        constructUrl('$nUser$nSearch/$query/$type'),
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<PopularSearchModel> popularSearch({
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {
    final res = await get<PopularSearchModel>(
        constructUrl('${nUser}popular-searches'),
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<RecentSearchModel> recentSearch({
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {
    final res = await get<RecentSearchModel>(
        constructUrl('${nUser}recent-searches'),
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<CardModel> fetchMyCard(
    String customerStripeId, {
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {
    final res = await get<CardModel>(
        constructUrl('$nPayment$nOptions/$customerStripeId'),
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<DeadlineModel> getDeadline(
    String teamId, {
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {
    final res = await get<DeadlineModel>(
        constructUrl('teams/current-order/$teamId?trim=true'),
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<BaseModel> addMyCard(
    Map<String, dynamic> body, {
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {
    final res = await post<BaseModel>(constructUrl('$nPayment$nAddCard'),
        body: body,
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<BaseModel> markCardPrimary(
    Map<String, dynamic> body, {
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {
    final res = await post<BaseModel>(constructUrl('${nPayment}default-card'),
        body: body,
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<BaseModel> removeCard(
    Map<String, dynamic> body, {
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {
    final res = await delete<BaseModel>(constructUrl('${nPayment}remove-card'),
        body: body,
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<CustomerAddress> fetchMyAddress(
    String customerId, {
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {
    final res = await get<CustomerAddress>(
        constructUrl('$nUser$nDelvieryAddress/$customerId'),
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<OrderHistoryModel> fetchMyOrderHistory(
    String customerId, {
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {
    final res = await get<OrderHistoryModel>(
        constructUrl('$nUser$nOrderHistory/$customerId'),
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<UserBasketModel> fetchUserBasket(
    String teamId, {
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {
    final res = await post<UserBasketModel>(constructUrl('$nUser$nBasket'),
        body: {'teamId': teamId},
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<NotificationModel> fetchMyNotifications(
    String customerId, {
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {
    final res = await get<NotificationModel>(
        constructUrl('$nNotifications/$customerId'),
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<BaseModel> readMyNotifications(
    String customerId, {
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {
    final res = await patch<BaseModel>(constructUrl(nNotifications),
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError,
        body: {'userId': customerId});

    return res!.data;
  }

  Future<RequestSendModel> fetchMyRequest(
    String customerId, {
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {
    final res = await get<RequestSendModel>(
        constructUrl('$nUser$nRequests/$customerId'),
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<List<String>> fetchNearByLocation(
    String postalCode, {
    VoidCallback? errorCallBack,
  }) async {
    //  n16%209ju
    var request =
        'https://api.getaddress.io/v2/uk/$postalCode?api-key=oh93u09r10uI2D42JSkU1w38759';
    final http.Response response = await client.get(Uri.parse(request));
    late NearByLocations location;

    if (response.statusCode == 200) {
      location = NearByLocations.fromJson(json.decode(response.body));
    } else {
      location = NearByLocations();
    }

    return location.addresses ?? [];
  }

  Future<ChargeModel> chargeUser(
    Map<String, dynamic> body, {
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {

//    body['amount'] = body['amount'].round();

    final res = await post<ChargeModel>(
      constructUrl('$nPayment$nCharge'),
      body: body,
      throwOnError: throwOnError,
      snackbarOnError: snackBarOnError,
      retry: false,
      errorCallBack: errorCallBack,
    );

    return res!.data;
  }

  Future<PaymentIntentModel> paymentIntent(
    Map<String, dynamic> body, {
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {
    final res = await post<PaymentIntentModel>(
      constructUrl('${nPayment}intent'),
      body: body,
      throwOnError: throwOnError,
      snackbarOnError: snackBarOnError,
      retry: false,
      errorCallBack: errorCallBack,
    );

    return res!.data;
  }

  Future<BaseModel> removeFromBasket(
    String id, {
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {
    final res = await delete<BaseModel>(constructUrl('$nPayment$nBasket/$id'),
        throwOnError: throwOnError, snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<BaseModel> updateQtyBasket(
    Map<String, dynamic> body, {
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {
    final res = await patch<BaseModel>(constructUrl('$nPayment$nBasket'),
        body: body,
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError);

    return res!.data;
  }

  Future<TeamCreationModel> createTeam(
    Map<String, dynamic> body, {
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {
    final res = await post<TeamCreationModel>(
      constructUrl('$nTeams/$nCreate'),
      body: body,
      throwOnError: throwOnError,
      snackbarOnError: snackBarOnError,
      retry: false,
      errorCallBack: () {
        print("2");
        errorCallBack!.call();
      },
    );

    return res!.data;
  }

  Future<BulkUploadedModel> uploadProducts(
    Map<String, dynamic> body, {
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {
    final res = await post<BulkUploadedModel>(
        constructUrl('$nPayment$nBasketBulk'),
        body: body,
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError,
        retry: false,
        errorCallBack: errorCallBack);

    return res!.data;
  }

  Future<BulkUploadedModel> updateBasket(
    Map<String, dynamic> body, {
    throwOnError = true,
    snackBarOnError = true,
    VoidCallback? errorCallBack,
  }) async {
    print(body.toString());
    final res = await patch<BulkUploadedModel>(
        constructUrl('$nPayment$nBasketBulk'),
        body: body,
        throwOnError: throwOnError,
        snackbarOnError: snackBarOnError,
        retry: false,
        errorCallBack: errorCallBack);

    return res!.data;
  }

  void cancelRequest() {
    cancelToken.cancel();
    cancelToken = CancelToken();
  }
}
