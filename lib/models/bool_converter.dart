import 'package:dart_json_mapper/dart_json_mapper.dart';

class CustomBoolConverter implements ICustomConverter<bool> {
  const CustomBoolConverter() : super();

  @override
  bool fromJSON(dynamic jsonValue, DeserializationContext context) {
    return jsonValue == 1;
  }

  @override
  dynamic toJSON(bool object, SerializationContext context) {
    return '_${object ? 1 : 0}_';
  }
}
