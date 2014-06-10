CREATING A NEW COMMENT
======================

You can attach a comment to any kind of post with this API.

API Endpoints

Create a comment
/api/comment/create

Delete a comment
(not implemented as yet)

AUTHENTICATION
==============
Only logged in users can create comments.
You are also able to enable new users to both create a comment and signup simultaneously by adding an "email" and "name" field to the comment form.

ALLOWED COMMENT FIELDS
======================

* zid (zid of the post you are attachign the comment to)
* parent_id (parent_id of a comment you are replying to)
* content
* content_format (text, html)
* email and name (authentication)
* attachments[]
  
If the user is already logged in you really need only two fields to add a comment:
* zid
* content

Other fields to control processing
-----------------------------------
  success_url (url to go to after successfully creating the post)
  failure_url (url to redirect to if post failed)
  failure_template (template to render if fails)
  success_template (template to render if success)
  callback (calls a javascript function to take some kind of action named in "callback") This is useful if you post from an iframe. Will call "my_cleanup_script(error_msg)" if there was an error, so you need to handle it.

COMPLETE EXAMPLE (FOR LOGGED IN USER)
======================================

<!-- displaying the question -->
<h1>{{question.title}}</h1>
{{question.content | newline_to_br}}
<hr />

<!-- and its replies -->
<h4>Replies</h4>
<ul>
{% for r in question.responses %}
<li>{{r.content}}</li>
{% endfor %}
</ul>

<!-- then the comment form -->
<form method="POST" action="/api/comment/create">
  {{csrf}}
  
  <!-- the question zid -->
  <input type="hidden" name="zid" value="{{question.zid}}" />
  
  <!-- where to go if there is an error or success -->
  <input type="hidden" name="success_url" value="{{question.permalink}}" />
  <input type="hidden" name="failure_url" value="{{question.permalink}}" />

  <label>Add your reply</label>
  <textarea name="content" rows="4" class="span6"></textarea>
  <p>
    <input type="submit" value="Reply" />
  </p>
</form>

