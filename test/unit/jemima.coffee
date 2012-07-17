
# Dependencies
{assert} = require 'chai'
er = require 'er'
sinon = require 'sinon'


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

    test 'should return `true` when the object has the property tested for', ->
      assert.isTrue jemima.hasProperty {foo: 'bar'}, 'foo'

    test 'should return `true` when the object\'s prototype has the property tested for', ->
      class Foo
        foo: 'bar'
      assert.isTrue jemima.hasProperty new Foo, 'foo'

    test 'should return `false` when the object does not have the property tested for', ->
      assert.isFalse jemima.hasProperty {}, 'foo'

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

    test 'should return `true` when the object has all properties tested for', ->
      assert.isTrue jemima.hasProperties {foo: 'bar', bar: 'baz'}, ['foo', 'bar']

    test 'should return `true` when the object\'s prototype has all properties tested for', ->
      class Foo
        foo: 'bar'
        bar: 'baz'
      assert.isTrue jemima.hasProperties new Foo, ['foo', 'bar']

    test 'should return `true` when the combination of the object and object prototype has all properties tested for', ->
      class Foo
        foo: 'bar'
      object = new Foo
      object.bar = 'baz'
      assert.isTrue jemima.hasProperties object, ['foo', 'bar']

    test 'should return `false` when the object does not have at least one of the properties tested for', ->
      assert.isFalse jemima.hasProperties {foo: 'bar'}, ['foo', 'bar']

    suite 'called with correct arguments', ->
      object = result = null

      setup ->
        sinon.spy jemima, 'hasProperty'
        object = {foo: 123}
        result = jemima.hasProperties object, ['foo', 'bar', 'baz']

      teardown ->
        jemima.hasProperty.restore()
        object = result = null

      test 'should call `jemima.hasProperty` a number of times equal to the length of the array of properties', ->
        assert.isTrue jemima.hasProperty.calledThrice

      test 'should call `jemima.hasProperty` with the object passed in as a first argument', ->
        assert.isTrue jemima.hasProperty.firstCall.calledWith(object)
        assert.isTrue jemima.hasProperty.secondCall.calledWith(object)
        assert.isTrue jemima.hasProperty.thirdCall.calledWith(object)

      test 'should call `jemima.hasProperty` with each property in the array of properties as a second argument', ->
        assert.isTrue jemima.hasProperty.firstCall.calledWith(object, 'foo')
        assert.isTrue jemima.hasProperty.secondCall.calledWith(object, 'bar')
        assert.isTrue jemima.hasProperty.thirdCall.calledWith(object, 'baz')

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

    test 'should return `true` when the object has the method tested for', ->
      assert.isTrue jemima.hasMethod {foo: ->}, 'foo'

    test 'should return `true` when the object\'s prototype has the method tested for', ->
      class Foo
        foo: ->
      assert.isTrue jemima.hasProperty new Foo, 'foo'

    test 'should return `false` when the object does not have the method tested for', ->
      assert.isFalse jemima.hasMethod {}, 'foo'

    test 'should return `false` when the object has a non-function property matching the method name being tested for', ->
      assert.isFalse jemima.hasMethod {foo: 'bar'}, 'foo'

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

    test 'should return `true` when the object has all methods tested for', ->
      assert.isTrue jemima.hasMethods {foo: (->), bar: (->)}, ['foo', 'bar']

    test 'should return `true` when the object\'s prototype has all methods tested for', ->
      class Foo
        foo: ->
        bar: ->
      assert.isTrue jemima.hasMethods new Foo, ['foo', 'bar']

    test 'should return `true` when the combination of the object and object prototype has all methods tested for', ->
      class Foo
        foo: ->
      object = new Foo
      object.bar = ->
      assert.isTrue jemima.hasMethods object, ['foo', 'bar']

    test 'should return `false` when the object does not have at least one of the methods tested for', ->
      assert.isFalse jemima.hasMethods {foo: (->), bar: 'baz'}, ['foo', 'bar']

    suite 'called with correct arguments', ->
      object = result = null

      setup ->
        sinon.spy jemima, 'hasMethod'
        object = {foo: (->)}
        result = jemima.hasMethods object, ['foo', 'bar', 'baz']

      teardown ->
        jemima.hasMethod.restore()
        object = result = null

      test 'should call `jemima.hasMethod` a number of times equal to the length of the array of methods', ->
        assert.isTrue jemima.hasMethod.calledThrice

      test 'should call `jemima.hasMethod` with the object passed in as a first argument', ->
        assert.isTrue jemima.hasMethod.firstCall.calledWith(object)
        assert.isTrue jemima.hasMethod.secondCall.calledWith(object)
        assert.isTrue jemima.hasMethod.thirdCall.calledWith(object)

      test 'should call `jemima.hasMethod` with each property in the array of methods as a second argument', ->
        assert.isTrue jemima.hasMethod.firstCall.calledWith(object, 'foo')
        assert.isTrue jemima.hasMethod.secondCall.calledWith(object, 'bar')
        assert.isTrue jemima.hasMethod.thirdCall.calledWith(object, 'baz')
