lib = require('./lib');
Q = require('Q');

console.log(lib.countryCounter('RU', function (result){
    console.log('Super result is ' + result)
}));