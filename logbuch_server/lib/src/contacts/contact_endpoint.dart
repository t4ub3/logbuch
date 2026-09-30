import 'package:logbuch_server/src/generated/protocol.dart';
import 'package:logbuch_server/src/generated/serverpod.dart';

class ContactEndpoint extends Endpoint {
  Future<List<Contact>> getAll(Session session) async {
    return Contact.db.find(session);
  }

  Future<Contact?> getById(Session session, int id) async {
    return Contact.db.findById(session, id);
  }

  Future<Contact> add(Session session, Contact contact) async {
    return await Contact.db.insertRow(session, contact);
  }
}
