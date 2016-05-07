from __future__ import unicode_literals

from django.db import models


class Tweet(models.Model):
    tweet = models.CharField(max_length=256)