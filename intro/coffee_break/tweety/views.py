from django.http import JsonResponse
from django.views.generic.base import TemplateView


class Index(TemplateView):
    template_name = "tweety/index.html"

    def get_context_data(self, *args, **kwargs):
        context = super(Index, self).get_context_data(**kwargs)
        context['tweets'] = {'tweets': [{'tweet': 'What if Kanye made a song about Kanye', },
                                        {'tweet': "Man that'd be so Kanye" , },
                                        {'tweet': 'We still love Kanye', },
                                        {'tweet': 'And I love you like Kanye loves Kanye', },
                                        ]}
        return context
