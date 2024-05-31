import 'package:rabble/core/config/export.dart';
import 'package:rabble/feature/buying_team/setting/manage_member/manage_members_view.dart';
import 'package:rabble/feature/hub/all_partner_teams_view.dart';
import 'package:rabble/feature/hub/partner_team_view.dart';
import 'package:rabble/feature/qrcode/qr_code_view.dart';

import '../../feature/buying_team/all/existing_buying_team_view.dart';

class Routes {
  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = RouteHandlers.notFoundHandler;
    // register all the routes here

    defineRoute(
        router, '/onboard', RouteHandlers.makeHandler(() => OnBoardView()));

    defineRoute(router, '/login', RouteHandlers.makeHandler(() => LoginView()));

    defineRoute(
        router, '/home', RouteHandlers.makeHandler(() => const HomeView()));

    defineRoute(router, '/detail',
        RouteHandlers.makeHandler(() => const ProductDetailView()));

    defineRoute(router, '/producer',
        RouteHandlers.makeHandler(() => const ProducerView()));

    defineRoute(
        router, '/splash', RouteHandlers.makeHandler(() => const SplashView()));

    defineRoute(router, '/force_update',
        RouteHandlers.makeHandler(() => const ForceUpdate()));

    defineRoute(router, '/subscriber',
        RouteHandlers.makeHandler(() => const SubscriberView()));

    defineRoute(router, '/my_subscriptions_view',
        RouteHandlers.makeHandler(() => const MySubscriptionsView()));

    defineRoute(
      router,
      '/web/:url/:title',
      RouteHandlers.webScreenHandler,
    );

    defineRoute(router, '/all_buying_teams_view',
        RouteHandlers.makeHandler(() => const AllBuyingTeamsView()));

    defineRoute(router, '/request_to_join_view',
        RouteHandlers.makeHandler(() => const RequestToJoin()));

    defineRoute(router, '/add_postal_code_view',
        RouteHandlers.makeHandler(() => AddPostalAddressView()));

    defineRoute(router, '/request_subscriber',
        RouteHandlers.makeHandler(() => const RequestSubscriberView()));

    defineRoute(router, '/verify_otp',
        RouteHandlers.makeHandler(() => const VerifyOtpView()));

    defineRoute(router, '/checkout',
        RouteHandlers.makeHandler(() => const CheckoutView()));


    defineRoute(router, '/producer_list_view',
        RouteHandlers.makeHandler(() => const ProducerListView()));

    defineRoute(router, '/search_product_view',
        RouteHandlers.makeHandler(() => const SearchProductView()));

    defineRoute(router, '/edit_payment_view',
        RouteHandlers.makeHandler(() => const EditPaymentView()));

    defineRoute(router, '/my_rabble_account_view',
        RouteHandlers.makeHandler(() => const MyRabbleAccountView()));

    defineRoute(router, '/notification_list_view',
        RouteHandlers.makeHandler(() => NotificationTabView()));

    defineRoute(router, '/edit_profile_view',
        RouteHandlers.makeHandler(() => EditProfileView()));

    defineRoute(router, '/setting_view',
        RouteHandlers.makeHandler(() => const SettingView()));

    defineRoute(router, '/my_buying_team_view',
        RouteHandlers.makeHandler(() => const MyBuyingTeamView()));

    defineRoute(router, '/choose_frequency_view',
        RouteHandlers.makeHandler(() => ChooseFrequencyView()));

    defineRoute(router, '/subscription_shipment_view',
        RouteHandlers.makeHandler(() => CurrentSubscriptionShipmentView()));

    defineRoute(router, '/order_history_view',
        RouteHandlers.makeHandler(() => const OrderHistoryView()));

    defineRoute(router, '/buy_team_order_history_view',
        RouteHandlers.makeHandler(() => const BuyingTeamOrderHistoryView()));

    defineRoute(router, '/team_host_view',
        RouteHandlers.makeHandler(() => const TeamHostView()));

    defineRoute(router, '/subscriber_profile_view',
        RouteHandlers.makeHandler(() => const SubscriberProfileView()));

    defineRoute(router, '/contact_view',
        RouteHandlers.makeHandler(() => const ContactSelectionView()));

    defineRoute(router, '/manage_members_view',
        RouteHandlers.makeHandler(() => ManageMembersView()));

    defineRoute(router, '/buying_team_view',
        RouteHandlers.makeHandler(() => BuyingTeamView()));

    defineRoute(router, '/select_payment_method_view',
        RouteHandlers.makeHandler(() => SelectPaymentMethodView()));

    defineRoute(router, '/review_payment_view',
        RouteHandlers.makeHandler(() => ReviewPaymentView()));

    defineRoute(router, '/add_payment_view',
        RouteHandlers.makeHandler(() => AddNewCardView()));

    defineRoute(router, '/edit_team_name_view',
        RouteHandlers.makeHandler(() => EditNameView()));

    defineRoute(router, '/edit_team_intro_view',
        RouteHandlers.makeHandler(() => EditTeamIntroductionView()));

    defineRoute(router, '/edit_frequency_view',
        RouteHandlers.makeHandler(() => EditFrequencyView()));

    defineRoute(router, '/edit_next_shipment_date_view',
        RouteHandlers.makeHandler(() => EditNextShipmentDateView()));

    defineRoute(router, '/add_custom_frequency_view',
        RouteHandlers.makeHandler(() => AddCustomFrequencyView()));

    defineRoute(router, '/my_subscribtion_view',
        RouteHandlers.makeHandler(() => MySubscribtionView()));

    defineRoute(router, '/create_group_name_view',
        RouteHandlers.makeHandler(() => CreateGroupNameView()));
    defineRoute(router, '/personalise_group_view',
        RouteHandlers.makeHandler(() => PersonaliseGroupView()));

    defineRoute(router, '/threshold_view',
        RouteHandlers.makeHandler(() => TeamView()));

    defineRoute(router, '/add_address_view',
        RouteHandlers.makeHandler(() => AddAddressView()));

    defineRoute(router, '/my_team_request_list_view',
        RouteHandlers.makeHandler(() => MyTeamRequestListView()));

    defineRoute(
        router, '/signup_view', RouteHandlers.makeHandler(() => SignUpView()));

    defineRoute(router, '/user_name_view',
        RouteHandlers.makeHandler(() => UserNameView()));

    defineRoute(router, '/my_checkout',
        RouteHandlers.makeHandler(() => MyCheckoutView()));
    defineRoute(router, '/chat_room',
        RouteHandlers.makeHandler(() => ChatRoomView()));
    defineRoute(router, '/team_list_view',
        RouteHandlers.makeHandler(() => TeamListView()));

    defineRoute(router, '/all_cards',
        RouteHandlers.makeHandler(() => AllCardView()));

    defineRoute(router, '/ExistingBuyingTeamsView',
        RouteHandlers.makeHandler(() => ExistingBuyingTeamsView()));

    defineRoute(router, '/AllPartnersTeams',
        RouteHandlers.makeHandler(() => AllPartnersTeamsView()));
    defineRoute(router, '/PartnerTeam',
        RouteHandlers.makeHandler(() => PartnerTeamView()));
    defineRoute(router, '/qrCode',
        RouteHandlers.makeHandler(() => QrCodeView()));
  }

  static void defineRoute(
    FluroRouter router,
    String routePath,
    Handler handler, {
    TransitionType transitionType = TransitionType.none,
  }) {
    router.define(
      routePath,
      handler: handler,
      transitionType: transitionType,
    );
  }

  static void defineFullScreenDialogRoute(
    FluroRouter router,
    String routePath,
    Handler handler, {
    TransitionType transitionType = TransitionType.materialFullScreenDialog,
  }) {
    router.define(
      routePath,
      handler: handler,
      transitionType: transitionType,
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        final tween = Tween<Offset>(begin: begin, end: end);
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
