class Xml

  constructor: () ->
    parser = new DOMParser()
    @xmlDoc = parser.parseFromString '<root></root>', 'text/xml'
    @serializer = new XMLSerializer()

  ###*
  # @param {Element} doc Document to convert to string.
  # @return {string}
  ###
  serialize: (doc) ->
    @serializer.serializeToString doc

  ###*
  # @param {string} name Name of the rule/sniff/file to exclude.
  # @return {Element}
  ###
  createExcludeNode: (name) ->
    @_createTag 'exclude', name: name

  ###*
  # @param {string} ref Name of the rule/sniff/file to include.
  # @return {Element}
  ###
  createRuleNode: (ref) ->
    @_createTag 'rule', ref: ref

  ###*
  # @param {string} name Name of the ruleset.
  # @return {Element}
  ###
  createRulesetNode: (name) ->
    @_createTag 'ruleset', name: name

  ###*
  # @param {string} tagName Name of the tag to create.
  # @param {object} attributes Attributes for created tag to have.
  # @return {Element}
  ###
  _createTag: (tagName, attributes = {}) ->
    el = @_createElement tagName
    for name, value of attributes
      el.setAttributeNode @_createAttribute name, value
    el

  ###*
  # @param {string} name Name of the element to create.
  # @return {Element}
  ###
  _createElement: (name) ->
    @xmlDoc.createElement name

  ###*
  # @param {string} name Name of the attribute.
  # @param {string|int|float} value Value of the attribute.
  # @return {Attr}
  ###
  _createAttribute: (name, value) ->
    attr = @xmlDoc.createAttribute name
    attr.nodeValue = value
    attr


module.exports = Xml
