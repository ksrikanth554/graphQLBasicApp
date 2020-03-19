import 'package:flutter/material.dart';
import 'package:mygraphql/alertdialog_window.dart';
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

    if(!result.hasException){

      for(int i=0;i<result.data["persons"].length;i++){
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
  _addPerson(BuildContext context){
    showDialog(
      context: context,
      builder: (ctx){
        return AlertDialogWindow(isAdd: true,);
        
      }
      );

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transacion'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_circle_outline),
           
            onPressed:(){
              setState(() {
                _addPerson(context);
              });
            } )
        ],

      ),
      body: Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                
                child: Text('Transaction',textAlign: TextAlign.center,style: TextStyle(fontSize: 30.0),),
              ),
              Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: listPerson.length,
                  itemBuilder:(ctx,index){
                    return ListTile(
                      title: Text('${listPerson[index].getName()}'),
                    );
                  }
                  ),
              )
            ],
      ),
      
    );
  }
}