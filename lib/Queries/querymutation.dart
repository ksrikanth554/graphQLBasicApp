class QueryMutation{

  String addPerson(String id,String name,String lastName,int age){
    return"""
       mutation {
  insert_persons(objects: [{id: "$id", name: "$name", lastname: "$lastName", age:"$age" }]) {
    returning {
      id
      name
      lastname
      age
    }
  }
}


    """;
  }

  String getAll(){

    return """
     query{
          persons{
            id
            name
            lastname
            age
          }
        }

    """;
  }

  String deletePerson(String id){

    return """
        mutation{
          deletePerson(id:"$id"){
            id
          }
        }
    """;

  }

  String editPerson(String id,String name,String lastName,int age){
    return """
      mutation{
        editPerson(id:"$id",name:"$name",lastName:"$lastName",age:"$age"){
          name
          lastname
        }
      }

    """;
  }
}