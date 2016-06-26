fs = require 'fs'


exports.countryCounter = (countryCode, cb) ->
  return cb() unless countryCode

  fs.readFile "#{__dirname}/../data/geo.txt", 'utf8', (err, data) ->
    if err then return cb err

    countryCodePattern = ///  #begining of line
      (#{countryCode})+       #concatinate the exact country code
      ///gm                   #end of line with global multiline flags
    
    data = data.match countryCodePattern    
#    data = data.match /([A-Z]{2})+/gm 

    counter = 0

    for line in data when line
      if line == countryCode then counter++
    
    cb null, counter
