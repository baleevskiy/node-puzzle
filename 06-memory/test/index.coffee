assert   = require 'assert'
util     = require 'util'

describe 'reader', ->

  describe 'countryCounter()', ->

    it 'should be memory efficient', ->
      heapUsageBefore = process.memoryUsage().heapUsed
      reader = require '../lib'
      reader.countryCounter(
        'RU'
        (result) ->
          console.log('TEST RESULT' + result)
          assert.equal result, 111054

      )

      heapUsageAfter = process.memoryUsage().heapUsed

      heapUsageIncrease = heapUsageAfter / heapUsageBefore

      assert heapUsageIncrease < 4, "Your heap memory usage increased more than 4 times"