import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mygraphql/Queries/querymutation.dart';
import 'package:mygraphql/graphql_config.dart';
import 'package:progress_dialog/progress_dialog.dart';
import './model/person.dart';

class AlertDialogWindow extends StatefulWidget {
final Person person;
final bool isAdd;

AlertDialogWindow({Key key,this.isAdd,this.person}):super(key:key);

  @override
  _AlertDialogWindowState createState() => _AlertDialogWindowState(this.person,this.isAdd);
}

class _AlertDialogWindowState extends State<AlertDialogWindow> {
  final Person person;
  final bool isAdd;
  _AlertDialogWindowState(this.person,this.isAdd);
  TextEditingController txtId=TextEditingController();
  TextEditingController txtName=TextEditingController();
  TextEditingController txtlastName=TextEditingController();
  TextEditingController txtage=TextEditingController();
  GraphQlConfiguration graphQlConfiguration=GraphQlConfiguration();
  QueryMutation addMutation=QueryMutation();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(!this.isAdd){
      txtId.text=person.getId();
      txtName.text=person.getName();
      txtlastName.text=person.getLastName();
      txtage.text=person.getLastName();
    }

  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(this.isAdd?'Add':'Edit Or Delete'),
      content: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width*0.02,
                  right: MediaQuery.of(context).size.width*0.02,

                ),
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  maxLength: 5,
                  controller: txtId,
                  decoration: InputDecoration(
                  labelText: 'ID'
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width*0.02,
                  right: MediaQuery.of(context).size.width*0.02,

                ),
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  maxLength: 25,
                  controller: txtName,
                  decoration: InputDecoration(
                  labelText: 'NAME'
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width*0.02,
                  right: MediaQuery.of(context).size.width*0.02,

                ),
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  maxLength: 25,
                  controller: txtlastName,
                  decoration: InputDecoration(
                  labelText: 'LAST NAME'
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width*0.02,
                  right: MediaQuery.of(context).size.width*0.02,

                ),
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  maxLength: 5,
                  controller: txtage,
                  decoration: InputDecoration(
                  labelText: 'AGE'
                  ),
                ),
              ),

            ],
          ),

        ),
      ),

      actions: <Widget>[
        FlatButton(onPressed: ()=>Navigator.of(context).pop(), child: Text('Close')),
        !this.isAdd?FlatButton(
          child: Text('Delete'),
          onPressed: (){

          },

        ):null,

        FlatButton( 
          child:Text(this.isAdd?'Add':'Edit'),
          onPressed: ()async{
             ProgressDialog progressDialog=ProgressDialog(context);
            
            
            if(txtId.text.isNotEmpty&&
                txtName.text.isNotEmpty&&
                txtlastName.text.isNotEmpty&&
                txtage.text.isNotEmpty){
                     progressDialog.update(message: 'Saving');
                      progressDialog.show();
                    if(this.isAdd){
                      GraphQLClient _client=graphQlConfiguration.clientQuery();

                      QueryResult result=await _client.mutate(

                         MutationOptions(
                           document: addMutation.addPerson(
                             txtId.text,
                              txtName.text,
                              txtlastName.text, 
                              int.parse(txtage.text),
                         ), 
                         ),
                      );

                      if(!result.hasException){
                        progressDialog.hide();
                        setState(() {
                        txtId.clear();
                        txtName.clear();
                        txtlastName.clear();
                        txtage.clear();
                        Navigator.pop(context);
                          
                        });
                       
                      }
                      if(result.hasException){
                        
                        progressDialog.hide();
                        showDialog(context: context,
                        builder: (ctx){
                          return AlertDialog(
                            title: Text('Error'),
                            content: Text('Saving Error'),
                            actions: <Widget>[
                              FlatButton(onPressed: ()=>Navigator.pop(context), child: Text('ok'))
                            ],
                          );
                        });
                      }
                      


                    }
                    else{
                      GraphQLClient _client=graphQlConfiguration.clientQuery();
                      QueryResult result=await _client.mutate(
                        MutationOptions(
                          document: addMutation.editPerson(
                            txtId.text,
                            txtName.text, 
                             txtlastName.text, 
                             int.parse(txtage.text)
                             ),

                        ),

                      );
                      if(!result.hasException){
                        txtId.clear();
                        txtName.clear();
                        txtlastName.clear();
                        txtage.clear();
                        Navigator.pop(context);
                      }
                    }


                }

            
          },
        
        )
      ],

      
    );
  }
}