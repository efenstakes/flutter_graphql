import 'package:flutter/material.dart';
import 'package:fluttr_graphql/details.page.dart';
import 'package:fluttr_graphql/home.page.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:routemaster/routemaster.dart';
import 'package:url_strategy/url_strategy.dart';


void main() async {
  
  // We're using HiveStore for persistence,
  // so we need to initialize Hive.
  await initHiveForFlutter();

  // remove # from web paths
  setPathUrlStrategy();

  return runApp(MyApp());
} 


final routes = RouteMap(
  routes: {
    '/': (_) => MaterialPage(child: HomePage()),
    '/details/:id': (info) { 
      print('at routes info id ${info.pathParameters['id']}');
      return MaterialPage(
        child: DetailsPage(id: '1'), // info.pathParameters['id']
      );
    }
  },
);
class MyApp extends StatelessWidget {
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
      child: MaterialApp.router(
        routerDelegate: RoutemasterDelegate(routesBuilder: (_) => routes),
        routeInformationParser: RoutemasterParser(),
      ),
    );
  }
}