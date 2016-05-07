from __future__ import unicode_literals

from django.db import models

class Comment(models.Model):
    name = models.CharField(max_length=35)
    opinion = models.CharField(max_length=256)