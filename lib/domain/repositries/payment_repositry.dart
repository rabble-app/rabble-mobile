import 'package:rabble/config/export.dart';
import 'package:rabble/domain/entities/CardModel.dart';
import 'package:rabble/domain/entities/ChargeModel.dart';

class PaymentRepository extends BaseRepository {
  final ApiProvider _apiProvider = ApiProvider();

  @throws
  Future<BaseModel?> addMyCard(Map<String, dynamic> body,
      {required throwOnError,VoidCallback? errorCallBack}) async {
    BaseModel? status =
        await _apiProvider.addMyCard(body, throwOnError: throwOnError,errorCallBack: errorCallBack);
    return status;
  }
  @throws
  Future<BaseModel?> markCardPrimary(Map<String, dynamic> body,
      {required throwOnError,VoidCallback? errorCallBack}) async {
    BaseModel? status =
        await _apiProvider.markCardPrimary(body, throwOnError: throwOnError,errorCallBack: errorCallBack);
    return status;
  }

  @throws
  Future<BaseModel?> removeCard(Map<String, dynamic> body,
      {required throwOnError,VoidCallback? errorCallBack}) async {
    BaseModel? status =
        await _apiProvider.removeCard(body, throwOnError: throwOnError,errorCallBack: errorCallBack);
    return status;
  }

  @throws
  Future<CardModel?> fetchMyCard(String customerStripeId,
      {required throwOnError,VoidCallback? errorCallBack}) async {
    CardModel? status = await _apiProvider.fetchMyCard(customerStripeId,
        throwOnError: throwOnError,errorCallBack: errorCallBack);
    return status;
  }@throws
  Future<DeadlineModel?> getDeadline(String teamId,
      {required throwOnError,VoidCallback? errorCallBack}) async {
    DeadlineModel? status = await _apiProvider.getDeadline(teamId,
        throwOnError: throwOnError,errorCallBack: errorCallBack);
    return status;
  }

  @throws
  Future<ChargeModel?> chargeUser(Map<String, dynamic> body,
      {required throwOnError,VoidCallback? errorCallBack,}) async {
    ChargeModel? status = await _apiProvider.chargeUser(body,
        throwOnError: throwOnError,errorCallBack: errorCallBack);
    return status;
  }
  @throws
  Future<PaymentIntentModel?> paymentIntent(Map<String, dynamic> body,
      {required throwOnError,VoidCallback? errorCallBack,}) async {
    PaymentIntentModel? status = await _apiProvider.paymentIntent(body,
        throwOnError: throwOnError,errorCallBack:errorCallBack );
    return status;
  }
  @throws
  Future<BaseModel?> removeFromBasket(String itemId,
      {required throwOnError,VoidCallback? errorCallBack}) async {
    BaseModel? status = await _apiProvider.removeFromBasket(itemId,
        throwOnError: throwOnError,errorCallBack: errorCallBack);
    return status;
  }
  @throws
  Future<BaseModel?> updateQtyBasket(Map<String, dynamic> body,
      {required throwOnError,VoidCallback? errorCallBack}) async {
    BaseModel? status = await _apiProvider.updateQtyBasket(body,
        throwOnError: throwOnError,errorCallBack: errorCallBack);
    return status;
  }

}
