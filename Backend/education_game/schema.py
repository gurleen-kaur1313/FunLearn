import graphene
import graphql_jwt
import userProfile.schema
import tasks.schema


class Query(userProfile.schema.Query, tasks.schema.Query, graphene.ObjectType):
    pass


class Mutation(userProfile.schema.Mutation, tasks.schema.Mutation, graphene.ObjectType):
    token_auth = graphql_jwt.ObtainJSONWebToken.Field()
    verify_token = graphql_jwt.Verify.Field()
    refresh_token = graphql_jwt.Refresh.Field()


schema = graphene.Schema(query=Query, mutation=Mutation)
