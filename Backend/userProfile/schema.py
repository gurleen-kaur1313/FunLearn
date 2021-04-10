from django.db import models
import graphene
from django.contrib.auth import get_user_model
from graphene_django import DjangoObjectType
from .models import UserProfile, TeacherProfile, Batch
from graphql import GraphQLError
from django.db.models import Q


class Profile(DjangoObjectType):
    class Meta:
        model = UserProfile


class Query(graphene.ObjectType):
    me = graphene.Field(Profile)
    leaderboard = graphene.List(Profile)

    def resolve_me(self, info):
        u = info.context.user
        if u.is_anonymous:
            raise GraphQLError("Not Logged In!")
        return UserProfile.objects.get(user=u)

    def resolve_leaderboard(self, info, **kwargs):
        u = info.context.user
        if u.is_anonymous:
            raise GraphQLError("Not Logged In!")
        p = UserProfile.objects.get(user=u)
        return UserProfile.objects.filter(batch=p.batch).order_by("-score")


class CreateUser(graphene.Mutation):
    user = graphene.Field(Profile)

    class Arguments:
        username = graphene.String(required=True)
        password = graphene.String(required=True)
        email = graphene.String(required=True)
        name = graphene.String()
        roll = graphene.String()

    def mutate(self, info, username, password, email, **kwargs):
        user = get_user_model()(
            username=username,
            email=email,
        )
        user.set_password(password)
        user.save()
        profile = UserProfile.objects.create(user=user, name=kwargs.get(
            "name"),  email=email, rollNo=kwargs.get("roll"))
        profile.save()

        return CreateUser(user=user)


class UpdateScore(graphene.Mutation):
    update = graphene.Field(Profile)

    class Arguments:
        life = graphene.Int(required=False)
        score = graphene.Int(required=False)
        gameScore = graphene.Int(required=False)

    def mutate(self, info, **kwargs):

        user = info.context.user

        if user.is_anonymous:
            raise GraphQLError("Not Logged In!")

        profile = UserProfile.objects.get(user=user)

        score = kwargs.get("score")
        lifes = kwargs.get("life")
        game = kwargs.get("gameScore")

        profile.score = score
        profile.life = lifes
        profile.gameScore = game
        profile.save()

        return UpdateScore(update=profile)


class DeleteUser(graphene.Mutation):
    user = graphene.String()

    def mutate(self, info):
        user = info.context.user

        if user.is_anonymous:
            raise GraphQLError("Not Logged In!")

        user.delete()
        str = "Done!"

        return DeleteUser(user=str)


class Mutation(graphene.ObjectType):
    create_user = CreateUser.Field()
    update_user = UpdateScore.Field()
    delete_user = DeleteUser.Field()
