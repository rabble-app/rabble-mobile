import 'package:contacts_service/contacts_service.dart';
import 'package:rabble/core/config/export.dart';
import 'package:rabble/domain/entities/contact_data.dart';
import 'package:rxdart/rxdart.dart';

class ContactCubit extends RabbleBaseCubit with Validators {
  ContactCubit() : super(RabbleBaseState.idle()) {
    fetchContacts();
  }

  TextEditingController controller = TextEditingController();

  BehaviorSubject<int> totalSelectedContactSubject$ =
      BehaviorSubject<int>.seeded(0);
  BehaviorSubject<List<ContactData>> contactDataSubject$ =
      BehaviorSubject<List<ContactData>>.seeded([]);

  BehaviorSubject<List<String>> contactsSubject$ =
      BehaviorSubject<List<String>>.seeded([]);

  void onSelectedContact(ContactData data) {
    if (!data.isSelected!) {
      data.isSelected = true;
      List<ContactData> list =
          contactDataSubject$.hasValue ? contactDataSubject$.value : [];

      contactDataSubject$.sink.add(list);
      totalSelectedCount(true);
      List<String> contacts =
          contactsSubject$.hasValue ? contactsSubject$.value : [];
      contacts.add(data.subHeading!);
      contactsSubject$.sink.add(contacts);
    } else {
      data.isSelected = false;
      List<ContactData> list =
          contactDataSubject$.hasValue ? contactDataSubject$.value : [];
      contactDataSubject$.sink.add(list);
      totalSelectedCount(false);
      List<String> contacts =
          contactsSubject$.hasValue ? contactsSubject$.value : [];

      contacts.remove(data.subHeading!);
      contactsSubject$.sink.add(contacts);
    }
  }

  void totalSelectedCount(bool isSelected) {
    if (isSelected) {
      int totalValue = totalSelectedContactSubject$.value;
      totalValue++;
      totalSelectedContactSubject$.sink.add(totalValue);
    } else {
      {
        int totalValue = totalSelectedContactSubject$.value;
        if (totalValue != 0) {
          totalValue--;
        }
        totalSelectedContactSubject$.sink.add(totalValue);
      }
    }
  }

  List<ContactData> _filteredList = [];
  List<ContactData> _originalList = [];

  void searchContact(String query) {
    _filteredList = contactDataSubject$.hasValue
        ? contactDataSubject$.value
            .where((element) =>
                element.heading != null &&
                element.heading!.toLowerCase().contains(query.toLowerCase()))
            .toList()
        : [];

    contactDataSubject$.sink.add(_filteredList);
  }

  void resetContact() {
    _filteredList = _originalList;
    contactDataSubject$.sink.add(_filteredList);
  }

  Future<void> fetchContacts() async {
    emit(RabbleBaseState.primaryBusy());
    PermissionStatus permissionStatus = await Permission.contacts.request();

    if (permissionStatus.isGranted) {
      List<Contact> contacts = await ContactsService.getContacts();

      List<ContactData> list = [];

      for (Contact contact in contacts) {
        if (contact.phones != null && contact.phones!.isNotEmpty) {
          list.add(ContactData(
              contact.displayName ?? '',
              contact.phones != null && contact.phones!.isNotEmpty
                  ? contact.phones!.first.value!.trim()
                  : '',
              false));
        }
      }

      _originalList = list;
      contactDataSubject$.sink.add(list);
      _filteredList = list; // Update the _filteredList
    }
    emit(RabbleBaseState.idle());
  }

  Future<String> generateDeepLink(TeamData teamData) async {
    final branchUniversalObject = BranchUniversalObject(
      canonicalIdentifier: teamData.id ?? '',
      title: teamData.name ?? '',
      imageUrl: teamData.imageUrl ?? '',
      contentDescription: teamData.description ?? '',
    );

    final branchLinkProperties = BranchLinkProperties(
      feature: 'Share',
      channel: 'Rabble app',
      campaign: 'Invitation for team.',
    );

    final generatedLink = await FlutterBranchSdk.getShortUrl(
        linkProperties: branchLinkProperties, buo: branchUniversalObject);

    print('Generated deep link: ${generatedLink.result.toString()}');

    return generatedLink.result.toString();
  }

  Future<void> inviteContacts(TeamData teamData) async {
    emit(RabbleBaseState.secondaryBusy());
    var deepLink = await generateDeepLink(teamData);

    var data = await RabbleStorage().retrieveDynamicValue(RabbleStorage().userKey);
    Map<String, dynamic> response = json.decode(data.toString().trim());

    UserModel userData = UserModel.fromJson(response);
    List<String> noSpacesContactList =
        contactsSubject$.value.map((s) => s.replaceAll(' ', '')).toList();

    Map<String, dynamic> inviteData = {
      "userId": userData.id!,
      "link": deepLink,
      "phones": noSpacesContactList,
      "teamId": teamData.id
    };

    BaseModel? inviteRes = await userRepo.inviteContacts(
        body: inviteData,
        throwOnError: true,
        errorCallBack: () {
          emit(RabbleBaseState.idle());
        });

    if (inviteRes!.status == 200) {
      globalBloc.showSuccessSnackBar(message: inviteRes.message);
    }

    emit(RabbleBaseState.idle());
  }
}
