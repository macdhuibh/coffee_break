import json
from django.views.generic.base import TemplateView
from models import Comment

class Index(TemplateView):
    template_name = "commenti/index.html"

    def get_context_data(self, *args, **kwargs):
        context = super(Index, self).get_context_data(**kwargs)

        comments = [{"name": comment.name, "opinion": comment.opinion}
                    for comment in Comment.objects.all()]

        # context['comments'] = [
        #     {"name": "Ray", "opinion": "It seems to me that.."},
        #     {"name": "Kanye", "opinion": "And I love you like Kanye loves Kanye"}
        # ]
        context['comments'] = json.dumps(comments)
        return context
