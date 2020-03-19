import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './graphql_config.dart';
import './transactio.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main(){

      runApp(
        GraphQLProvider(
          client: GraphQlConfiguration.client,
          //client: GraphQlConfiguration().client,
        
          child: CacheProvider(child:MyApp()),
        )
      );

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Transactions',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: Transaction(),
    );
  }
}