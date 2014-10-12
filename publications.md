---
layout: default
---
<div class="post">

  <header class="post-header">
    <h1>Publications</h1>
  </header>

  <article class="post-content">
  <ul class="citation-list list-unstyled">
      {% assign year = 0 %}
      {% assign pubs = site.data.publications | sort: 'year' %}
      {% for item in pubs reversed %}
          {% if year != item.year %}
              {% assign year = item.year %}
              <hr>
              <h2>{{year}}</h2>
          {% endif %}
          <li>{{ item.a_cite | trim | markdownify }}
         </li>
      {% endfor %}
  <ul>
</article>

</div>