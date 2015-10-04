$("#new_post").on("ajax:error", (e, data, status, xhr) ->
  $("#errors ul").append('<li>' + data.responseJSON + '</li>')
)
