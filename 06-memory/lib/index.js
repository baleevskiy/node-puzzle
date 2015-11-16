fs = require('fs')
rl = require('readline')
Q = require('Q')

function countryCounter(countryCode){
    var deferred = Q.defer();
    var num = 0;
    var rl = require('readline').createInterface({
        input: require('fs').createReadStream('data/geo.txt')
    });

    rl.on('line', function (line) {
        line = line.split('\t')
        if(line[3] == countryCode)
            num += 1;
        //console.log('Line from file:', line);
    });

    rl.on('close', function (){
        console.log('CLOSE');
        deferred.resolve(num)
    })

    return deferred.promise
}


exports.countryCounter = function (countryCode ,cb){
    countryCounter(countryCode).then(cb)
}