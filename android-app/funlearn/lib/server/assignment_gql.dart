import 'package:funlearn/model/assignments.dart';
import 'package:funlearn/server/login_gql.dart';
import "package:graphql/client.dart";

List<Assignments> listA = [];
int pendingA=0;

Future<bool> getAssignment() async {
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
  myA{
    id
    subject
    name
    submitted
    submissionurl
    ontime
    added
    duedate
    totalmarks
    marksobtained
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
  var ass = data.data["myA"];
  for (var assdata in ass) {
    pendingA++;
    Assignments ass = new Assignments();
    ass.id = assdata["id"];
    ass.name = assdata["name"];
    ass.subject = assdata["subject"];
    ass.submitted = assdata["submitted"];
    ass.submissionurl = assdata["submissionurl"];
    ass.ontime = assdata["ontime"];
    ass.added = assdata["added"];
    ass.duedate = assdata["duedate"].toString();
    ass.totalmarks = assdata["totalmarks"];
    ass.marksobtained = assdata["marksobtained"];
    listA.add(ass);
  }
  return true;
}
