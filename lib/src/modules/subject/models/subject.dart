import 'package:equatable/equatable.dart';

class Subject extends Equatable {
  const Subject(this.id, this.name);

  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];

  static const list = [
    Subject(1, 'Physics'),
    Subject(2, 'Chemistry'),
    Subject(3, 'Biology'),
    Subject(4, 'Maths'),
    Subject(5, 'English'),
  ];
}
