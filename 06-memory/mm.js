lib = require('./lib');
Q = require('Q');

lib.countryCounter('RU', function (result){
    console.log('Super result is ' + result)
});