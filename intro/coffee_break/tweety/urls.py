from django.conf.urls import url

from tweety import views


urlpatterns = [
    url(r'^$', views.Index.as_view(), name='index'),
]
