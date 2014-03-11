
# Jemima #

A naïve little (puddle) duck typing library for Node.js

**NOTE: This project is no longer being maintained. If you're interested in taking over maintenance of this repo, please contact me.**

[![Build Status][travis-status]][travis]


## Installation ##

Just install with `npm install jemima` or add it to your
`package.json`.

If you use a bundler like [Browserify][browserify], then Jemima
will work just fine in-browser too.


## Usage ##

You can use Jemima with JavaScript or CoffeeScript:

```js
var jemima = require('jemima');
```

```coffeescript
jemima = require 'jemima'
```

Jemima exposes a few functions to help duck-type:


### jemima.hasProperty ###

This function tests to see whether an object has the specified
property. You call it with an object (what we're testing) and a
string (the property we're testing for); it will return a
boolean value indicating whether the object has the property:

```js
var obj = {
    foo: 123
};

jemima.hasProperty(obj, 'foo'); // true
jemima.hasProperty(obj, 'bar'); // false
```


### jemima.hasProperties ###

This function tests to see whether an object has the specified
properties. You call it with an object (what we're testing) and
an array of strings (the properties we're testing for); it will
return a boolean value indicating whether the object has *all*
of the properties:

```js
var obj = {
    foo: 123,
    bar: 456
};

jemima.hasProperties(obj, ['foo', 'bar']); // true
jemima.hasProperties(obj, ['foo', 'baz']); // false
```


### jemima.hasMethod ###

This function tests to see whether an object has the specified
method – it's similar to `hasProperty` but also tests that the
property is a function. You call it with an object (what we're
testing) and a string (the method we're testing for); it will
return a boolean value indicating whether the object has the
method:

```js
var obj = {
    foo: function () {},
    bar: 123
};

jemima.hasMethod(obj, 'foo'); // true
jemima.hasMethod(obj, 'bar'); // false
```


### jemima.hasMethods ###

This function tests to see whether an object has the specified
methods – it's similar to `hasProperties` but also tests that
the properties are functions. You call it with an object (what
we're testing) and an array of strings (the methods we're
testing for); it will return a boolean value indicating whether
the object has *all* of the methods:

```js
var obj = {
    foo: function () {},
    bar: function () {},
    baz: 123
};

jemima.hasMethods(obj, ['foo', 'bar']); // true
jemima.hasMethods(obj, ['foo', 'baz']); // false
```


### jemima.matches ###

This function tests whether an object has the specified
properties and that the type of object stored in each property
is as expected. You call it with an object (what we're testing)
and a 'duck' (an object which specifies the expected properties
and types); it will return a boolean value indicating whether
all of the properties match:

```js
var duck = {
    foo: 'string',
    bar: 'function'
};

jemima.matches({
    foo: 'bar',
    bar: function () {}
}, duck); // true

jemima.matches({
    foo: 'bar'
}, duck); // false

jemima.matches({
    foo: 'bar',
    bar: 'baz'
}, duck); // false
```


## Development ##

In order to develop Jemima, you'll need to install the following
npm modules globally like so:

    npm install -g coffee-script
    npm install -g jake

And then install development dependencies locally with:

    npm install

Once you have these dependencies, you will be able to run the
following commands:

`jake build`: Build JavaScript from the CoffeeScript source.

`jake lint`: Run CoffeeLint on the CoffeeScript source.

`jake test`: Run all unit tests.


## License ##

Dual licensed under the [MIT][mit] or [GPL Version 2][gpl]
licenses.


[browserify]: https://github.com/substack/node-browserify
[gpl]: http://opensource.org/licenses/gpl-2.0.php
[mit]: http://opensource.org/licenses/mit-license.php
[travis]: https://travis-ci.org/rowanmanning/jemima
[travis-status]: https://travis-ci.org/rowanmanning/jemima.png?branch=master
