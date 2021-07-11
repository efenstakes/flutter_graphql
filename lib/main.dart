// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {
  
  // We're using HiveStore for persistence,
  // so we need to initialize Hive.
  await initHiveForFlutter();
  return runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink =
        HttpLink('https://rickandmortyapi.com/graphql/');

    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
          cache: GraphQLCache(store: HiveStore()),
          link: httpLink as Link),
    );
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String query = """
            query {
            characters(page:10) {
              results {
                name
                species
                gender
                image
                type
              }
            }
          }
        """;
        
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rick & Morty'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Query(
        options: QueryOptions(document: gql(query)),
        builder: (QueryResult result, { VoidCallback? refetch, FetchMore? fetchMore }) {
          if (result.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (result.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: EdgeInsets.all(5),
                onTap: ()=> _func(),
                title: Text(
                  result.data?['characters']['results'][index]['name'],
                ),
                leading: Image.network(
                  result.data?['characters']['results'][index]['image'],
                ),
                subtitle: Text(
                  result.data?['characters']['results'][index]['species'],
                ),
              );
            },
            itemCount: result.data?['characters']['results'].length,
          );
        },
      ),
    );
  }// build



  void _func() {
    Radius radius = Radius.circular(40);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          maxChildSize: 0.99,
          minChildSize: 0.5,
          initialChildSize: 0.6,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: radius, topRight: radius,
                ),
              ),
              child: ListView.builder(
                controller: scrollController,
                itemCount: 100,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 12,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.lightBlueAccent[400],
                        radius: 60,
                      ),
                      title: Text('Item $index')),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }// _func
}