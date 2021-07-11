import 'package:flutter/material.dart';
import 'package:fluttr_graphql/queries.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rick and Morty',
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Query(
        options: QueryOptions(
          document: gql(Get_Characters),
        ),
        builder: (QueryResult result) {


        },
      ),
    );
  }
}