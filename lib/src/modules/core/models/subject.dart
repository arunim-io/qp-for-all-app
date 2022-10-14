import 'package:equatable/equatable.dart';

class Subject extends Equatable {
  const Subject(this.id, this.name);

  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}
