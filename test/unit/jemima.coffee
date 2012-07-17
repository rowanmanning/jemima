
# Dependencies
{assert} = require 'chai'
er = require 'er'


# Tests
suite 'jemima module', ->
  jemima = require '../../src/jemima'

  test 'should be an object', ->
    assert.isObject jemima

  test 'should have a `hasProperty` function', ->
    assert.isFunction jemima.hasProperty

  test 'should have a `hasProperties` function', ->
    assert.isFunction jemima.hasProperties

  test 'should have a `hasMethod` function', ->
    assert.isFunction jemima.hasMethod

  test 'should have a `hasMethods` function', ->
    assert.isFunction jemima.hasMethods

  suite '`hasProperty` function', ->

    test 'should not throw when called with correct arguments', ->
      assert.doesNotThrow -> jemima.hasProperty {}, 'foo'

    test 'should throw when called with a non-object first argument', ->
      assert.throws ->
        jemima.hasProperty 123, 'foo'
      , er.ArgumentTypeError

    test 'should throw when called with a non-string second argument', ->
      assert.throws ->
        jemima.hasProperty {}, 123
      , er.ArgumentTypeError

    test 'should throw when called with an empty string second argument', ->
      assert.throws ->
        jemima.hasProperty {}, ''
      , er.ArgumentError

    test 'should throw when called with a missing first argument', ->
      assert.throws ->
        jemima.hasProperty undefined, 'foo'
      , er.ArgumentMissingError

    test 'should throw when called with a missing second argument', ->
      assert.throws ->
        jemima.hasProperty {}
      , er.ArgumentMissingError

  suite '`hasProperties` function', ->

    test 'should not throw when called with correct arguments', ->
      assert.doesNotThrow -> jemima.hasProperties {}, ['foo']

    test 'should throw when called with a non-object first argument', ->
      assert.throws ->
        jemima.hasProperties 123, ['foo']
      , er.ArgumentTypeError

    test 'should throw when called with a non-array second argument', ->
      assert.throws ->
        jemima.hasProperties {}, 'foo'
      , er.ArgumentTypeError

    test 'should throw when called with an empty array second argument', ->
      assert.throws ->
        jemima.hasProperties {}, []
      , er.ArgumentError

    test 'should throw when called with an array second argument that contains a non-string value', ->
      assert.throws ->
        jemima.hasProperties {}, ['foo', 123]
      , er.ArgumentTypeError

    test 'should throw when called with a missing first argument', ->
      assert.throws ->
        jemima.hasProperties undefined, ['foo']
      , er.ArgumentMissingError

    test 'should throw when called with a missing second argument', ->
      assert.throws ->
        jemima.hasProperties {}
      , er.ArgumentMissingError

  suite '`hasMethod` function', ->

    test 'should not throw when called with correct arguments', ->
      assert.doesNotThrow -> jemima.hasMethod {}, 'foo'

    test 'should throw when called with a non-object first argument', ->
      assert.throws ->
        jemima.hasMethod 123, 'foo'
      , er.ArgumentTypeError

    test 'should throw when called with a non-string second argument', ->
      assert.throws ->
        jemima.hasMethod {}, 123
      , er.ArgumentTypeError

    test 'should throw when called with an empty string second argument', ->
      assert.throws ->
        jemima.hasMethod {}, ''
      , er.ArgumentError

    test 'should throw when called with a missing first argument', ->
      assert.throws ->
        jemima.hasMethod undefined, 'foo'
      , er.ArgumentMissingError

    test 'should throw when called with a missing second argument', ->
      assert.throws ->
        jemima.hasMethod {}
      , er.ArgumentMissingError

  suite '`hasMethods` function', ->

    test 'should not throw when called with correct arguments', ->
      assert.doesNotThrow -> jemima.hasMethods {}, ['foo']

    test 'should throw when called with a non-object first argument', ->
      assert.throws ->
        jemima.hasMethods 123, ['foo']
      , er.ArgumentTypeError

    test 'should throw when called with a non-array second argument', ->
      assert.throws ->
        jemima.hasMethods {}, 'foo'
      , er.ArgumentTypeError

    test 'should throw when called with an empty array second argument', ->
      assert.throws ->
        jemima.hasMethods {}, []
      , er.ArgumentError

    test 'should throw when called with an array second argument that contains a non-string value', ->
      assert.throws ->
        jemima.hasMethods {}, ['foo', 123]
      , er.ArgumentTypeError

    test 'should throw when called with a missing first argument', ->
      assert.throws ->
        jemima.hasMethods undefined, ['foo']
      , er.ArgumentMissingError

    test 'should throw when called with a missing second argument', ->
      assert.throws ->
        jemima.hasMethods {}
      , er.ArgumentMissingError
