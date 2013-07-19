# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->

  # User list online/offline updater.
  PrivatePub.subscribe "/users/list", (data, channel) ->
    $("#userlist ul").html("")
    #console.log(data)
    current_user = $("#user_id").text()
    for user in data.users

      # Don't show current user
      if user._id.$oid == current_user
        continue

      if user.online
        user_status_color = 'lightgreen'
      else
        user_status_color = 'lightgrey'
      
      icon = $("<i/>", {
                style: 'color: ' + user_status_color,
                class: 'icon-circle' 
              })
      link = $("<a/>", {
                href: '/conversations/0/' + user._id.$oid,
                text: user.name,
                'data-remote': true,
              })

      if user.online
        $("<li/>").append(icon).append(link).appendTo("#userlist ul")
      else
        $("<li/>").append(icon).append(user.name).appendTo("#userlist ul")


  # Update 'task post times' every minute      
  setInterval () ->
    $(".post_time_of_task").each ->
      minutes = parseInt($(this).text())
      $(this).html(minutes+1)
      task = $(this).parent().parent()
      back_color = if (minutes > 60) then 195 else (255-minutes)
      task.css("background","rgba(255," + back_color + "," + back_color + ",1)")
  , 1000*60

  #window.onbeforeunload = (e) ->
  #  $.ajax({ 
  #          url : "/users/sign_out",
  #          type: "delete"
  #        })
  #  return "Bye"