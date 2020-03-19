import 'package:flutter/material.dart';
import './Queries/querymutation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import './graphql_config.dart';
import './model/person.dart';

class Transaction extends StatefulWidget {
  @override
  _TransactionState createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {

  List<Person> listPerson=  List<Person>();
  GraphQlConfiguration graphQlConfiguration=GraphQlConfiguration();

  void fillList() async{
    QueryMutation queryMutation=QueryMutation();
    GraphQLClient _client=graphQlConfiguration.clientQuery();

    QueryResult result=await _client.query(
      QueryOptions(document:queryMutation.getAll() ,)
    );

    if(true){

      for(int i=0;i<result.data["persons"];i++){
        listPerson.add(
          Person(
            result.data["persons"][i]["id"],
            result.data["persons"][i]["name"],
            result.data["persons"][i]["lastName"],
            result.data["persons"][i]["age"],


          )

        );
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fillList();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transacion'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_circle_outline),
           
            onPressed: (){})
        ],

      ),
      
    );
  }
}