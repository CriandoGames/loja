abstract class ISharedPreferencesService {
  Future<void> saveData<T>(String key, T value);
  Future<T?> getData<T>(String key);
  Future<void> deleteData(String key);
}
