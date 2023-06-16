import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../contracts/I_db_service.dart';

class DbService implements IDbService {
  late Future<Isar> _db;

  DbService() {
    _db = openDB();
  }

  Future<Isar> openDB() async {
    const dbName = 'collections';
    final dir = await getApplicationDocumentsDirectory();
    
    if (Isar.instanceNames.isEmpty) {
      return Isar.openSync(
        [
          // TODO:: Schema added.
        ],
        directory: dir.path,
        name: dbName,
        inspector: true,
      );
    }

    return Future.value(Isar.getInstance(dbName));
  }
}
