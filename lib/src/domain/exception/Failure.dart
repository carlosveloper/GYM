import 'dart:convert';

/* abstract class Failure extends Equatable {
  // If the subclasses have some properties, they'll get passed to this constructor
  // so that Equatable can perform value comparison.
  Failure([List properties = const <dynamic>[]]) : super(properties);
} */

abstract class Failure {
  void excute();
  String getMessageError();
}

class ServerFailure implements Failure {
  String message;
  ServerFailure({
    this.message,
  });

  @override
  void excute() {
    // TODO: implement excute
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
    };
  }

  factory ServerFailure.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ServerFailure(
      message: map['message'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ServerFailure.fromJson(String source) =>
      ServerFailure.fromMap(json.decode(source));

  @override
  String getMessageError() {
    return this.message;
  }
}
