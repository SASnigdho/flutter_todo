import '../models/task.dart';

abstract class IDbService {
  Future<List<Task>> getTasks();
  Future<void> save(Task task);
  Future<Task?> get(int id);
  Future<void> delete(Task task);
}
