import 'package:equatable/equatable.dart';

class Session extends Equatable {
  const Session(this.id, this.title);

  @override
  List<Object?> get props => [id, title];

  final int id;
  final String title;

  static const list = [
    Session(1, 'May/June 2022'),
    Session(2, 'January 2022'),
    Session(3, 'October/November 2021'),
    Session(4, 'May/June 2021'),
    Session(5, 'January 2021'),
  ];
}
