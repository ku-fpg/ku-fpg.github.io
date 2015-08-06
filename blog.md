---
layout: default
title: The Functional Programming Group
---

{% for post in site.posts %}

###  <a href="{{ post.url }}">{{ post.title }}</a>

{{ post.excerpt }}

{% endfor %}
