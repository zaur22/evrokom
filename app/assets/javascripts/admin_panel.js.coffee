changeMaterials = ->
  product = $("#system").val();
  $("#material").empty()
  unless product == "-1"
    materials = gon.select_options[product]
    if(materials)
      for material_id, att of materials
        title = att["title"]
        $("#material").append($("<option value=#{material_id}> #{title} </option>"))
  changeMaterialId()
  return

changeMaterialId=->
  val = $("#material").val()
  if val
    $("#material_id").val($("#material").val())
  else
    $("#material_id").val("-1")

$( ->
  if gon.page == "not_index"
    $("#list").sortable(
      {update: (event, ui)->
        $("#list [type=hidden]").each (sort_numb, input) ->
            $(input).attr("value", sort_numb + 1)

      create: (event, ui)->
        $("#list [type=hidden]").each (sort_numb, input) ->
          $(input).attr("value", sort_numb + 1)
      }
    )

    if(gon.select_options)
      for product, materials of gon.select_options
        $("#system").append($("<option value='#{product}'> #{product} </option>"))
      changeMaterials()

    $("#system").change ->
      changeMaterials()

    $("#material").change ->
      changeMaterialId()
  return
)