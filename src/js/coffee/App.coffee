class App

  ###*
  # @param {Xml} @xml My lib
  ###
  constructor: (@xml) ->

  run: ->
    ruleset = @xml.createRulesetNode 'Custom standard'
    rule = @xml.createRuleNode 'Squiz'
    exclude = @xml.createExcludeNode 'Squiz.PHP.CommentedOutCode'
    ruleset.appendChild rule
    rule.appendChild exclude
    console.log @xml.serialize ruleset


module.exports = App
