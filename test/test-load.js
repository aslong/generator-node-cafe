/*global describe, beforeEach, it*/
'use strict';
var assert = require('assert');

describe('node-cafe generator', function () {
  it('can be imported without blowing up', function () {
    var app = require('../generators/app');
    assert(app !== undefined);
  });
});