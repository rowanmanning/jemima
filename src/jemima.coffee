
# Dependencies
er = require 'er'


# Jemima
module.exports = jemima =

  # Check whether an object has a property
  hasProperty: (object, property) ->
    varg.isValidObjectArgument object
    varg.isValidPropertyArgument property

  # Check whether an object has properties
  hasProperties: (object, properties) ->
    varg.isValidObjectArgument object
    varg.isValidPropertiesArgument properties

  # Check whether an object has a method
  hasMethod: (object, method) ->
    varg.isValidObjectArgument object
    varg.isValidPropertyArgument method, 'method'

  # Check whether an object has methods
  hasMethods: (object, methods) ->
    varg.isValidObjectArgument object
    varg.isValidPropertiesArgument methods, 'methods'


# Argument verification
varg =

  notMissing: (object, arg) ->
    if object is undefined
      throw new er.ArgumentMissingError "Missing #{arg} argument"

  isObject: (object, arg) ->
    if typeof object isnt 'object'
      throw new er.ArgumentTypeError "Invalid #{arg} argument, object expected"

  isString: (object, arg) ->
    if typeof object isnt 'string'
      throw new er.ArgumentTypeError "Invalid #{arg} argument, string expected"

  isArray: (object, arg) ->
    if Array.isArray(object) is false
      throw new er.ArgumentTypeError "Invalid #{arg} argument, array expected"

  isUnemptyString: (object, arg) ->
    varg.isString object, arg
    if object is ''
      throw new er.ArgumentError "Invalid #{arg} argument, unempty string expected"

  isArrayOfStrings: (object, arg) ->
    varg.isArray object, arg
    if object.length is 0
      throw new er.ArgumentError "Invalid #{arg} argument, unempty array expected"
    for value in object
      if typeof value isnt 'string'
        throw new er.ArgumentTypeError "Invalid #{arg} argument, array of strings expected"

  isValidObjectArgument: (object) ->
    varg.notMissing object, 'object'
    varg.isObject object, 'object'

  isValidPropertyArgument: (property, arg = 'property') ->
    varg.notMissing property, arg
    varg.isUnemptyString property, arg

  isValidPropertiesArgument: (properties, arg = 'properties') ->
    varg.notMissing properties, arg
    varg.isArrayOfStrings properties, arg
