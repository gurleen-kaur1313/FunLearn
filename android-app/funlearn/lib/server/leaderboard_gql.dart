import 'package:funlearn/model/leaderboard_model.dart';
import 'package:funlearn/server/login_gql.dart';
import 'package:graphql/client.dart';

List<LeaderboardClass> leaders = [];

Future<bool> getleaderboard() async {
  HttpLink _httpLink = HttpLink(
    'https://funlearn.herokuapp.com/graphql/',
  );

  AuthLink _authLink = AuthLink(
    getToken: () async => 'JWT $token',
  );

  Link _link = _authLink.concat(_httpLink);
  GraphQLClient client = GraphQLClient(
    /// **NOTE** The default store is the InMemoryStore, which does NOT persist to disk
    cache: GraphQLCache(),
    link: _link,
  );

  String queryString = """
  
{
  leaderboard{
    id
    name
    image
    rollNo
    score
    gameScore
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
  var leaderdata = data.data["leaderboard"];
  for (var item in leaderdata) {
    String id = item["id"];
    String name = item["name"];
    String rollNo = item["rollNo"];
    String image = item["image"];
    int score = item["score"];
    int gameScore = item["gameScore"];
    LeaderboardClass obj =
        new LeaderboardClass(id, image, name, rollNo, score, gameScore);
    leaders.add(obj);
  }
  return true;
}
