abstract class Mapper<T extends Object> {
  const Mapper();

  T fromMap(Map<String, dynamic> map);
  Map<String, dynamic> toMap(T object);
}