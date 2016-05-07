from django.conf.urls import url, include
from rest_framework import routers, serializers, viewsets
from tweety import views
from tweety.models import Tweet


# Serializers define the API representation.
class TweetSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Tweet
        fields = ('tweet', )


# ViewSets define the view behavior.
class TweetViewSet(viewsets.ModelViewSet):
    queryset = Tweet.objects.all()
    serializer_class = TweetSerializer


# Routers provide an easy way of automatically determining the URL conf.
router = routers.DefaultRouter()
router.register(r'tweet', TweetViewSet)


urlpatterns = [
    url(r'^$', views.Index.as_view(), name='index'),
    url(r'^api/', include(router.urls)),
    url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework')),
]
