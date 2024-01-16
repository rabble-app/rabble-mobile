import 'package:rabble/config/export.dart';
import 'package:rabble/domain/repositries/chat_repositry.dart';

final authRepo = AuthRepository();
final producerRepo = ProducerRepository();
final buyingTeamRepo = BuyingTeamRepository();
final addressRepo = AddressRepository();
final searchRepo = SearchRepository();
final userRepo = UserRepository();
final paymentRepo = PaymentRepository();
final chatRepo = ChatRepository();

class RepositoryBarrel {
  static final RepositoryBarrel _instance = RepositoryBarrel._internal();

  RepositoryBarrel._internal();

  factory RepositoryBarrel() => _instance;

  /// You can only register adapters once, so keep track
  bool reposInitialized = false;

  static Future<void> resetAll() async {
    print("Resetting all repositories");
    try {
      //authRepo.reset();
      // All the async resets should go in here
      await FutureExt.allSettled(
        [
          authRepo.reset(),
        ],
        onError: (error, stackTrace) => print(
            "Something failed while resetting a particular repository $stackTrace,$error"),
      );
      RepositoryBarrel().reposInitialized = false;
      print("Successfully resetted all repositories");
    } catch (e) {
      print("Error resetting all repositories $e");
    }
  }

  Future<void> initializeAll() async {
    if (reposInitialized) {
      print("Repos already initialized -- aborting");
      return;
    }
    await Future.wait([
      authRepo.initialize(),
      producerRepo.initialize(),
      addressRepo.initialize(),
      buyingTeamRepo.initialize(),
      searchRepo.initialize(),
      userRepo.initialize(),
      paymentRepo.initialize(),
      chatRepo.initialize(),
    ]);
    reposInitialized = true;
  }
}
