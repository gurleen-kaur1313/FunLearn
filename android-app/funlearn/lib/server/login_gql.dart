import 'package:funlearn/model/profile_class.dart';
import 'package:funlearn/server/assignment_gql.dart';
import 'package:funlearn/server/leaderboard_gql.dart';
import 'package:funlearn/server/test_gql.dart';
import "package:graphql/client.dart";

String token = "";
MyProfile profile= new MyProfile();

Future<bool> login(String username, String password) async {
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

  String mutationString = """
  mutation{
  tokenAuth(username:"$username",password:"$password"){
    token
   
  }
}
""";

  MutationOptions options = MutationOptions(
    document: gql(mutationString),
  );

  QueryResult data = await client.mutate(options);
  if (data.hasException) {
    print(data.exception.toString());
    return false;
  }
  token = data.data["tokenAuth"]["token"];
  await getProfile();
  await getleaderboard();
  await getAssignment();
  await getTest();
  return true;
}



Future<bool> getProfile() async {
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
   me{
    id
    name
    image
    rollNo
    email
    score
    gameScore
    life
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
  var profiledata = data.data;
  profile.name = profiledata["me"]["name"];
  profile.email = profiledata["me"]["email"];
  profile.rollno = profiledata["me"]["rollNo"];
  profile.id = profiledata["me"]["id"];
  profile.image = profiledata["me"]["image"];
  profile.score = profiledata["me"]["score"];
  profile.gameScore = profiledata["me"]["gameScore"];
  profile.life = profiledata["me"]["life"];
  return true;
}

 
