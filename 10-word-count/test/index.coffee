assert = require 'assert'
WordCount = require '../lib'


helper = (input, expected, done) ->
  pass = false
  counter = new WordCount()

  counter.on 'readable', ->
    return unless result = this.read()
    assert.deepEqual result, expected
    assert !pass, 'Are you sure everything works as expected?'
    pass = true

  counter.on 'end', ->
    if pass then return done()
    done new Error 'Looks like transform fn does not work'

  counter.write input
  counter.end()


describe '10-word-count', ->

  it 'should count a single word', (done) ->
    input = 'test'
    expected = words: 1, lines: 1
    helper input, expected, done

  it 'should count words in a phrase', (done) ->
    input = 'this is a basic test'
    expected = words: 5, lines: 1
    helper input, expected, done

  it 'should count quoted characters as a single word', (done) ->
    input = '"this is one word!"'
    expected = words: 1, lines: 1
    helper input, expected, done

  # !!!!!
  # Make the above tests pass and add more tests!
  # !!!!!

  it.skip 'should count camel cased words as multiple words', (done) ->
    input = 'FunPuzzle'
    expected = words: 2, lines: 1
    helper input, expected, done
    
  it.skip 'should count total number of lines', (done) ->
    input = null
    expected = words: 2, lines: 1
    helper input, expected, done
    
    
  it.skip 'should count characters and bytes', (done) ->
    input = null
    expected = words: 2, lines: 1
    helper input, expected, done