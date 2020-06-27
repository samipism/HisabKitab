import 'package:contacts_service/contacts_service.dart';
import 'package:myproject/core/Failures.dart';
import 'package:myproject/core/Permission.dart';

class ContactsManager {
  ContactsManager();
  Future<List<String>> getContacts() async {
    if (await HandlePermission.permission.isContactPermitted()) {
      Iterable<Contact> _contacts =
          await ContactsService.getContacts(withThumbnails: false);
      List<String> _contactsName =
          _contacts.toList().map((e) => e.displayName).toList();
      return _contactsName;
    } else
      throw PermissionFailure();
  }
}
