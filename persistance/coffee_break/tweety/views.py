import json
from django.views.generic.base import TemplateView
from tweety.models import Tweet


class Index(TemplateView):
    template_name = "tweety/index.html"

    def get_context_data(self, *args, **kwargs):
        context = super(Index, self).get_context_data(**kwargs)

        tweets = [{'tweet': tweet.tweet}
                  for tweet in Tweet.objects.all()]

        context['tweets'] = json.dumps({'tweets': tweets})
        return context
