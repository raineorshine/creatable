###
Serializes the view data for bootstrapping and renders with the 'layout' view.
Sends the raw JSON if 'format=json'.
###
exports.render = (req, res, viewData) ->
  if req.query.format is 'json'
    res.send viewData
  else
    viewData.seed = JSON.stringify(viewData.seed)
    res.render 'layout', viewData
