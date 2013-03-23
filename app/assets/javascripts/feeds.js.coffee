mark_saved = (id) ->
  $('button[data-id="' + id + '"] i').addClass("icon-white")
  $('button[data-id="' + id + '"]').addClass('btn-danger').removeClass("disabled")

mark_unsaved = (id) ->
  $('button[data-id="' + id + '"] i').removeClass("icon-white")
  $('button[data-id="' + id + '"]').removeClass('btn-danger').addClass("disabled")

mark_read = (id) ->
  $("a.accordion-toggle[data-id='" + id + "']").addClass("muted")

toggle_saved = (id) ->
  if $('button[data-id="' + id + '"] i').hasClass("icon-white")
    mark_unsaved id
  else
    mark_saved id

$(".btn .icon-heart").parent().click ->
  feed_id = $(this).attr("data-parent-id")
  article_id = $(this).attr("data-id")  
  $.post("/feeds/" + feed_id + "/articles/" + article_id + "/toggle_saved", {id: article_id}).done(-> toggle_saved(article_id)).fail(-> alert("failed"))

$(".accordion-toggle").click ->
  feed_id = $(this).attr("data-parent-id")
  article_id = $(this).attr("data-id")  
  $.post("/feeds/" + feed_id + "/articles/" + article_id + "/mark_read", {id: article_id}).done(-> mark_read(article_id)).fail(-> alert("failed"))

