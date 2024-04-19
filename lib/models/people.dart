class People {
  final String name;

  const People({required this.name});
}

class ListGroup {
  final String name;
  final List<People> people;

  const ListGroup({
    required this.people,
    required this.name,
  });
}

final dummyDataGroup = ListGroup(
  name: 'Group1',
  people: List.generate(
    20,
    (index) => People(name: 'Person $index'),
  ),
);

final dummyAlone = [
  const People(name: "Wat"),
  const People(name: "Wat"),
  const People(name: "Wat"),
  const People(name: "Wat"),
  const People(name: "Wat"),
  const People(name: "Wat"),
  const People(name: "Wat"),
  const People(name: "Wat"),
  const People(name: "Wat"),
];
