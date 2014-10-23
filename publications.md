---
layout: default
---
<div class="post">
 {% assign debug = false %}
  <header class="post-header">
    <h1>Publications and Recent Submissions</h1>
  </header>

  <article class="post-content">
  <ul class="citation-list list-unstyled">
      {% assign pdf ="/images/pdficon_small.png)" | prepend: site.baseurl | prepend: '![](' %}
      {% assign year = 0 %}
      {% assign pubs = site.data.publications | sort: 'year' %}
      {% for item in pubs reversed %}
          {% if year != item.year %}
              {% assign year = item.year %}
              <hr>
              <h2>{{year}}</h2>
          {% endif %}
          <li>{{ item.a_cite | trim | markdownify }}
              {% if debug and item.links.size >= 0 %}
                  <ul>
                  {% for cite in item.links %}
                      <li>{{ cite | markdownify }}</li>
                  {% endfor %}
                  </ul>
              {% endif %}
         </li>
      {% endfor %}
  <ul>
</article>

</div>