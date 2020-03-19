class Person{
  final int id;
  final String name;
  final String lastName;
  final int age;
  Person(this.id,this.name,this.lastName,this.age);

  getName()=>this.name;
  getAge()=>this.age;
  getLastName()=>this.lastName;
  getId()=>this.id;
}