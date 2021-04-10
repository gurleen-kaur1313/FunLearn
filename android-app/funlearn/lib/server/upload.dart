import 'package:funlearn/server/login_gql.dart';
import "package:graphql/client.dart";

Future<bool> uploadA(String id, String url) async {
  HttpLink _httpLink = HttpLink(
    'https://funlearn.herokuapp.com/graphql/',
  );

  AuthLink _authLink = AuthLink(
    getToken: () async => 'JWT $token',
  );

  Link _link = _authLink.concat(_httpLink);
  GraphQLClient client = GraphQLClient(
    cache: GraphQLCache(),
    link: _link,
  );

  String queryString = """
mutation{
  updateAssignment(id: $id , url: $url){
    __typename
  }
}
""";

  MutationOptions options = MutationOptions(
    document: gql(queryString),
  );

  QueryResult data = await client.mutate(options);
  if (data.hasException) {
    print(data.exception.toString());
    return false;
  }

  return true;
}
