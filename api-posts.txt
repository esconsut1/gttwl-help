CREATING A NEW POST
===================

You can create a new post using the API without creating custom code.

API Endpoints
------------

Create a new post
/api/post/create

Destroy a post
/api/post/destroy

Update a post
/api/post/update

Get a list of posts
/api/posts

Get a single post
/api/post


HTTP VERBS
----------
Unless otherwise indicated the following HTTP verbs must be used as follows:

Creating records
POST

Updating records
PATCH

Deleting records
DELETE

Retrieving one or more records
GET


AUTHENTICATION
==============

All requests to the REST api should contain the parameter
"api_key" containing the key for your site

By default all liquid forms on the site with the {{csrf}} template variable will automatically add this key.


ALLOWED POST FIELDS
===================

Post fields
-----------
  zid (user's private zid, or: name & email) or will use current_user. If none of these, request will error out
  * title (required)
  content
  content_format (default text)
  permalink
  * kind (required -- see the list of allowed post kinds below)
  parent (zid of parent post)
  summary
  tags
  category_id
  external_link
  meta1 - 6
  agent_id
  price
  currency
  lang
  src
  src_id
  expires
  price_info
  place_id
  tags
  status (default 1, will be nil if pubdate)
  pubdate (parseable date string or nil)
  data (hash of custom fields)
  attachments[]
  url - URL pointing to a file, photo or video to embed with this post
  
Additional Fields for creating users
------------------------------------
These are useful for lead-generation forms.

  name
  -or-
  first_name, last_name
  email
  phone
  fax
  gender (m, f, t)
  organization
  address
  city
  region
  postal_code
  user_tags
  url
  agent_id (other author.id who is referring this one)
  location (eg: "Miami, Florida")
  dob (date of birth, eg: "11/06/1964" or other standard date format)
  user_meta (any string you like to help identify this user)
  user_data (a set of custom fields for this user, eg: user_data[age], user_data[weight])

Other fields to control processing
-----------------------------------
  success_url: (url to go to after successfully creating the post)
  failure_url: (url to redirect to if post failed)
  failure_template: (template to render if fails)
  success_template: (template to render if success)
  callback: (calls a javascript function to take some kind of action named in "callback") This is useful if you post from an iframe. Will call "my_cleanup_script(package)" with the result of the operation.
    The results of the operation is a json variable with the new post formatted exactly as the Liquid template variables.
  no_alert: do not do any post-processing or send any emails
  old_permalink: A permalink that we should use to redirect to the new post
  format: returns success or failure in JSON format. Currently only supports the value "json"


Kinds of posts allowed
-----------------------
  question
  video
  photo
  blog
  place
  product
  testimonial
  page
  offer
  news_feed
  database
  lead
  newsletter
  social
  tip


COMPLETE EXAMPLE (FOR LOGGED IN USER)
======================================

This example simulates a simple Q/A site and uses the "question" type of post.

Template path: "/questions" 
Page type: questions
-----------
<h1>Ask the Travel Agent</h1>

<!-- error handling -->
{% if error_message %}
<div class="notice">{{error_message}}</div>
{% endif %}

<!-- the form -->
<form method="POST" action="/api/post/create">
  <!-- you always need this variable ->
  {{csrf}}
  
  <!-- the kind of post to create -->
  <input type="hidden" name="kind" value="question" />
  
  <!-- where to redirect to after the post has been created -->
  <input type="hidden" name="success_url" value="/questions" />
  
  <!-- template to show if we failed (this is not a redirect, it just redraws the screen) -->
  <input type="hidden" name="failure_template" value="/questions" />

  <!-- you at least need the title field -->
  <label>Ask your question {{current_user.name}}</label>
  <input type="text" name="title" value="{{params.title}}" class="span8" />
  
  <p>
    <input type="submit" class="btn btn-success" />
  </p>
</form>

<!-- a list of questions -->
<ul>
{% for question in questions %}
  <li>
    <h4><a href="{{question.permalink}}">{{question.title}}</a></h4>
  </li>
{% endfor %}
</ul>


COMPLETE "AJAX" (iframe really) EXAMPLE
=======================================

You'd want to do this if you are uploading images instead of using real ajax. It gives you the same effect.

Template path: "/questions" 
Page type: questions
-----------
<h1>Ask the Travel Agent</h1>

<!-- notice we now add the target="myframe" that points to your iframe -->
<form method="POST" action="/api/post/create" target="myframe">
  {{csrf}}
  <input type="hidden" name="kind" value="question" />

  <!-- processor will call your javascript function afterwards -->
  <input type="hidden" name="callback" value="cleanup_questions" />

  <label>Ask your question {{current_user.name}}</label>
  <input type="text" name="title" value="{{params.title}}" class="span8" />
  <p>
    <input type="submit" class="btn btn-success" />
  </p>
</form>

<!-- iframe for psuedo-ajax style posting -->
<iframe name="myframe" width="0" height="0" border="0" style="display: none;"></iframe>

<!-- your callback script -->
<script type="text/javascript">
// This function can do things like refresh your question list, and clear the form
function cleanup_questions(msg) {
  if (msg) {
    alert(msg);
    return;
  }
  // we are good, so we can
  //... clear form
  //... refresh list
 alert('Thank you!');
}
</script>

<!-- list of questions -->
<ul>
{% for question in questions %}
  <li>
    <h4><a href="{{question.permalink}}">{{question.title}}</a></h4>
  </li>
{% endfor %}
</ul>

UPDATING A POST COMPLETE EXAMPLE
=================================

<h1>{{question.title}}</h1>
{{question.content | newline_to_br}}
<hr />

<form method="POST" action="/api/post/update">
  {{csrf}}
  <input type="hidden" name="_method" value="patch" />
  
  <input type="hidden" name="zid" value="{{question.zid}}" />
  
  <input type="hidden" name="success_url" value="{{question.permalink}}" />
  <input type="hidden" name="failure_url" value="{{question.permalink}}" />

  <label>Update this question</label>
  <input type="text" name="title" class="span6" value="{{question.title}}" />

  <label>More details</label>
  <textarea name="content" rows="4" class="span6">{{question.content | escape}}</textarea>
  <p>
  <input type="submit" value="Update" />
  </p>
</form>

THANK YOU PAGE
==============

After creating a post with the API, the post is available for some time in the {{after_created}} variable.

For instance, you can display elements of the post on your thank-you page.

DELETING A POST
===============

Endpoint:
/api/post/destroy/:zid

The zid belongs to a post to be destroyed. Only the person who created the post can delete it.

Example:
/api/post/destroy/123-fjs-123-sdj-989-123?return_url=/my-questions

The above would delete the post and redirect when completed to the value of "return_url".
