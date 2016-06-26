through2 = require 'through2'


module.exports = ->
  words = 0
  lines = 1

  transform = (chunk, encoding, cb) ->

#    trimmed = chunk.replace /^\s+|\s+$/g, ""
    wordCountPattern = ///   #begining of line
        ("[^"]+")   #strings within quotes as 1 word
        |           #or
        \S+         #any non space chain of charactors
    ///g            #end of line with global flag

#    tokens = chunk.match(/("[^"]+")|\S+/g)
                              
    tokens = chunk.match wordCountPattern
    words = tokens.length
    
    return cb()

  flush = (cb) ->
    this.push {words, lines}
    #this.push null
    return cb()

  return through2.obj transform, flush
