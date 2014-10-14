# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


window.onload = ->
  animate_time = 800
  slider_pause_time = 8000
  pageScrollTime = 3000
  headerHeight = 76

  $window = $(window)
  $fixed_header = $("#fixed_header_wrapper")
  top = true
  $window.on("scroll", ()->
    scroll();
  )
  scroll = ->
    y = $window.scrollTop();
    if ($window.width() < 1380)
      if (y > 450)
          if (top)
              $fixed_header.slideDown("fast")
          top = false
      else
          if (!top)
             $fixed_header.slideUp("fast")
          top = true
    else
      if (y > 770)
          if (top)
              $fixed_header.slideDown("fast")
          top = false
      else
          if (!top)
              $fixed_header.slideUp("fast")
          top = true
  
  scroll_block = $('.scroll-pane').jScrollPane({
    animateScroll: true,
    animateDuration: animate_time,
    animateEase: "swing"
  })
  scroll_api = scroll_block.data('jsp')

  ### scroll ###
  pageHeight = $("#content").height() 
  $(".scroll").click( ->
    scrollId = $(this).attr("href")
    OY = $(scrollId).position().top - headerHeight + 20
    scrollTime = pageScrollTime * (OY / pageHeight)
    $.scrollTo(OY, scrollTime)
  )

  ###-------- SLIDER ---------###
  ### catalog animation params ###
  num = $("#slides_wrap").data("length")
  horizontal_width = $('#items-horizontal').width()
  params =
    time: animate_time
    pause_time: slider_pause_time
    page: 1
    number: num
    page_width: horizontal_width
    scroll_api: scroll_api
    movement: true
    intervalID: null

  ### Start ###
  resize_slider()
  $("#items_block li").first().addClass("active")

  ### Rules ###
  $("#next").click(->
    next_slide(params)
  )
  $("#prev").click(->
    prev_slide(params)
  )
  $(".item").click(->
    numb_of_slide = $(this).data("slide-item")
    go_to_slide(params, numb_of_slide)
  )

  ### Timer ###
  if params.movement
    params.intervalID = setInterval(
      ()->
        next_slide(params)
        return
      , slider_pause_time  
    )

  $("#start-stop").click(->
    start_stop(params)
    return
  )

  ###-------- OUR WORK ---------###
  num = $("#our-work ul").data("length")
  image_sl_params =
    time: 500
    pause_time: 5000
    page: 1
    number: num
    movement: true
    intervalID: null

  $("[data-image-num=" + image_sl_params.page + "]").css("display", "block")  
  $("[data-image-num=" + image_sl_params.page + "]").css("z-index", "2")
  next_image(image_sl_params)
  $("#previous-image").click(->
    prev_image(image_sl_params)
  )
  $("#next-image").click(->
    next_image(image_sl_params)
  )
  

  ###------ Ajax submit ------###
  $("#new_client").on("ajax:send", ->
    $("#send_inquiry").val("Идет отправка...")
    $("#send_inquiry").prop('disabled', true);
    $("#send_inquiry").css("background-color", "#e96650")
  ).on("ajax:success", ->
    $("#send_inquiry").val("Заказ отправлен!")
  ).on "ajax:error", ->
    $("#send_inquiry").val("Ошибка")



  #-------------------#
  return
  ###______END______###





###_______________^_^___________________###





resize_slider = ->
  slides_wrap = $('#slides_wrap')
  page_width = slides_wrap.width()
  $(".slide-page").width(page_width)
  number = slides_wrap.data("length")
  slides_wrap.width(number * page_width)
  return

next_slide = (params)->
  restart_timer(params)
  if params.page is params.number
    changeItem(params.page, 1, params.scroll_api)
    params.page = 1
  else
    changeItem(params.page, params.page + 1, params.scroll_api)
    params.page = params.page + 1
  left = -1 * (params.page - 1) * params.page_width
  $('#slides_wrap').animate(
    {left: left},
    params.time,
    "swing"
  )
  return

prev_slide = (params)->
  restart_timer(params)
  if params.page is 1
    changeItem(params.page, params.number, params.scroll_api)
    params.page = params.number
  else
    changeItem(params.page, params.page - 1, params.scroll_api)
    params.page = params.page - 1
  left = -1 * (params.page - 1) * params.page_width
  $('#slides_wrap').animate(
    {left: left},
    params.time,
    "swing"
  )
  return

go_to_slide = (params, numb_of_slide)->
  if params.page isnt numb_of_slide
    changeItem(params.page, numb_of_slide, params.scroll_api)
    params.page = numb_of_slide
    left = -1 * (params.page - 1) * params.page_width
    $('#slides_wrap').animate(
      {left: left},
      params.time,
      "swing"
    )
  return

changeItem = (old_number, new_number, scroll_api)->
  new_item = $("[data-slide-item=" + new_number + "]")
  ### styles ###
  $("[data-slide-item=" + old_number + "]").removeClass("active")
  new_item.addClass("active")
  ### scroll ###
  scroll_api.scrollToElement(new_item, false)
  return

start_stop = (params)->
  if params.movement
    params.movement = false
    clearInterval(params.intervalID)
    $("#start-stop").removeClass("play")
    $("#start-stop").addClass("pause")
  else
    params.movement = true
    params.intervalID = setInterval(
      ()->
        next_slide(params)
        return
      , params.pause_time  
    )
    $("#start-stop").removeClass("pause")
    $("#start-stop").addClass("play")

    return

restart_timer = (params)->
  if params.movement
    clearInterval(params.intervalID)
    params.intervalID = setInterval(
      ()->
        next_slide(params)
        return
      , params.pause_time  
    )
  return

next_image = (params)->
  restart_image_sl_timer(params)
  old_page = params.page
  $("[data-image-num=" + params.page + "]").css("z-index", "1")
  if params.page is 1
    params.page = params.number
  else
    params.page = params.page - 1
  $("[data-image-num=" + params.page + "]").css("z-index", "2")
  $("[data-image-num=" + params.page + "]").fadeIn(params.time)
  setTimeout(->
      $("[data-image-num=" + old_page + "]").css("display", "none")
    , params.time
  )
  return

prev_image = (params)->
  restart_image_sl_timer(params)
  old_page = params.page
  $("[data-image-num=" + params.page + "]").css("z-index", "1")
  if params.page is params.number
    params.page = 1
  else
    params.page = params.page + 1
  $("[data-image-num=" + params.page + "]").css("z-index", "2")
  $("[data-image-num=" + params.page + "]").fadeIn(params.time)
  setTimeout(->
      $("[data-image-num=" + old_page + "]").css("display", "none")
    ,params.time
  )
  return

restart_image_sl_timer = (params)->
  clearInterval(params.intervalID)
  params.intervalID = setInterval(
    ()->
      next_image(params)
      return
    , params.pause_time  
  )