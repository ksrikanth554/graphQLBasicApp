class QueryMutation{

  String addPerson(int id,String name,String lastName,int age){
    return"""
        mutation{
          addPerson(id:"$id",name:"$name",lastName:"$lastName",age:"$age"){
            id
            name
            lastName
            age
          }
        }


    """;
  }

  String getAll(){

    return """
      {
        persons{
          id
          name
          lastName
          age
        }

      }

    """;
  }

  String deletePerson(int id){

    return """
        mutation{
          deletePerson(id:"$id"){
            id
          }
        }
    """;

  }

  String editPerson(int id,String name,String lastName,int age){
    return """
      mutation{
        editPerson(id:"$id",name:"$name",lastName:"$lastName",age:"$age"){
          name
          lastName
        }
      }

    """;
  }
}