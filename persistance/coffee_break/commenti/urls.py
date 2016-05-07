from django.conf.urls import url, include
from rest_framework import routers, serializers, viewsets
import views
from models import Comment


# serializers define the API representation
class CommentSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Comment
        fields = ('name', 'opinion',)


# Viewsets define the view behavior
class CommentViewSet(viewsets.ModelViewSet):
    queryset = Comment.objects.all()
    serializer_class = CommentSerializer


#Router provides a way to determine the URL conf
router = routers.DefaultRouter()
router.register(r'comment', CommentViewSet)


urlpatterns = [
    url(r'^$', views.Index.as_view(), name='index'),
    url(r'^api/', include(router.urls)),
    url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework')),
]
