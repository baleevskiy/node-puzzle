fs = require 'fs'
q = require 'Q'
rl = require('readline')


counter = (countryCode, cb) ->
  rl createInterface

for line in data when line
  line = line.split '\t'
  # GEO_FIELD_MIN, GEO_FIELD_MAX, GEO_FIELD_COUNTRY
  # line[0],       line[1],       line[3]

  if(typeof counter[line[3]] != 'undefined')
    counter[line[3]] += 1
  else
    counter[line[3]] = 1
#if line[3] == countryCode then counter++

console.log(counter)

exports.countryCounter = (countryCode, cb) ->
  return null unless countryCode
  return counter(countryCode, cb)
