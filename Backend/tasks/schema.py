from userProfile.models import UserProfile
from django.db import models
import graphene
from django.contrib.auth import get_user_model
from django.utils import timezone
from graphene_django import DjangoObjectType
from .models import Assignment, Test
from graphql import GraphQLError
from django.db.models import Q


class Assignments(DjangoObjectType):
    class Meta:
        model = Assignment


class Tests(DjangoObjectType):
    class Meta:
        model = Test


class Query(graphene.ObjectType):
    myA = graphene.List(Assignments)
    mtT = graphene.List(Tests)

    def resolve_myA(self,info):
        u = info.context.user
        if u.is_anonymous:
            raise GraphQLError("Not Logged In!")
        return Assignment.objects.filter(student=u).order_by("-added")

    def resolve_myT(self,info):
        u = info.context.user
        if u.is_anonymous:
            raise GraphQLError("Not Logged In!")
        return Test.objects.all().order_by("-added")


class UpdateAssignment(graphene.Mutation):
    update=graphene.Field(Assignments)

    class Arguments:
        url=graphene.String()
        id= graphene.String()

    def mutate(self,info,url, id):

        user = info.context.user
        if user.is_anonymous:
            raise GraphQLError("Not Logged In!")

        p = UserProfile.objects.get(user=user)
        a = Assignment.objects.get(id=id)
        a.url = url
        if timezone.now() > a.duedate:
            a.ontime = "Y"
            p.score += 10
        else:
            a.ontime = "N"
            p.score -= 5

        a.save()
        p.save()
        return UpdateAssignment(update=a)

class Mutation(graphene.ObjectType):
    update_assignment = UpdateAssignment.Field()
