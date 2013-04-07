feed_id = (item) ->
  $(item).attr('data-parent-id')

article_id = (item) ->
  $(item).attr('data-id')

mark_saved = (id) ->
  $('button[data-id="' + id + '"] i').addClass("icon-white")
  $('button[data-id="' + id + '"]').addClass('btn-danger').removeClass("disabled")

mark_unsaved = (id) ->
  $('button[data-id="' + id + '"] i').removeClass("icon-white")
  $('button[data-id="' + id + '"]').removeClass('btn-danger').addClass("disabled")

mark_read = (id) ->
  $("a.accordion-toggle[data-id='" + id + "']").addClass("muted")

mark_unread = (id) ->
  $("a.accordion-toggle[data-id='" + id + "']").removeClass("muted")

toggle_saved = (id) ->
  if $('button[data-id="' + id + '"] i').hasClass("icon-white")
    mark_unsaved id
  else
    mark_saved id

$('.refresh').click ->
  $.post("/feeds/refresh").done(-> alert("Reload Things")).fail(-> alert("failed"))


$('.mark-all-read').click ->
  unread_items = $(".accordion-toggle:not(.muted)").map ->
    item = new Object()  
    item['article'] = article_id(this)
    item['feed'] = feed_id(this)
    mark_read(item['article'])
    return item
  $.post("/feeds/mark_all_read", {items: unread_items.get()}).fail(-> alert('failed'))  
  

$(".btn .icon-heart").parent().click ->
  f = feed_id(this)
  a = article_id(this)
  $.post("/feeds/" + f + "/articles/" + a + "/toggle_saved", {id: a}).done(-> toggle_saved(a)).fail(-> alert("failed"))

$(".accordion-toggle").click ->
  if not $(this).hasClass('muted')
    f = feed_id(this)
    a = article_id(this)
    $.post("/feeds/" + f + "/articles/" + a + "/mark_read", {id: a}).done(-> mark_read(a)).fail(-> alert("failed"))

$(".keep-unread").click ->
  f = feed_id(this)
  a = article_id(this)
  $.post("/feeds/" + f + "/articles/" + a + "/mark_unread", {id: a}).done(-> mark_unread(a)).fail(-> alert("failed"))

