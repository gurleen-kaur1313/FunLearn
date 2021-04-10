import 'package:funlearn/model/test.dart';
import 'package:funlearn/server/login_gql.dart';
import "package:graphql/client.dart";

List<TestClass> listT = [];
int pendingT = 0;

Future<bool> getTest() async {
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
{
  mtT{
    id
    subject
    date
    totalmarks
    marksobtained
    added
  }
}
""";

  QueryOptions options = QueryOptions(
    document: gql(queryString),
  );

  QueryResult data = await client.query(options);
  if (data.hasException) {
    print(data.exception.toString());
    return false;
  }
  if (data == null) {
    return true;
  }
  var dat = data.data["mtT"];
  if (dat != null) {
    for (var testdata in dat) {
      pendingT++;
      TestClass test = new TestClass();
      test.id = testdata["id"];
      test.subject = testdata["subject"];
      test.date = testdata["date"];
      test.totalmarks = testdata["totalmarks"];
      test.marksobtained = testdata["marksobtained"];
      test.added = testdata["added"];
      listT.add(test);
    }
  }
  return true;
}
