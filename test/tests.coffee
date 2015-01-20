chai = require 'chai'

nconf = require 'nconf'
nconf_stripJsonComments = require '../index', {}

expect = chai.expect

commentedJsonFilePath = require('path').resolve('test/fixtures/commented.json')


describe 'nconf-strip-json-comments', ->

  afterEach ->
    nconf_stripJsonComments.restore nconf

  # Don't test for failing parsing with plain nconf
  # as nconf's default behavior might change in the future:

  # it 'should fail parsing commented JSON with plain nconf', ->
  #   expect =>
  #     nconf.file commentedJsonFilePath
  #   .to.throw Error

  it 'should enable nconf to parse commented JSON files by default', ->
    n = nconf_stripJsonComments nconf

    # nconf should now be able to parse the included, commented JSON file
    expect =>
      nconf.file commentedJsonFilePath
    .to.not.throw Error
    expect(nconf.get('a')).to.equal 'a value'

    # nconf instance itself should be returned
    expect(n).to.equal nconf

  it 'should expose a format', ->
    format = nconf_stripJsonComments.format

    # check that formatter exist
    expect(format).to.exist
    expect(format.parse).to.be.a 'Function'
    expect(format.stringify).to.be.a 'Function'

    # basic check if formatter works
    input = '{"x": 99 /* a comment */}'
    parsedInput = format.parse input
    expect(parsedInput.x).to.equal 99

  it 'should enable nconf to parse commented JSON files individually', ->
    format = nconf_stripJsonComments.format

    expect =>
      nconf.file
        file: commentedJsonFilePath
        format: format
    .to.not.throw Error
    expect(nconf.get('a')).to.equal 'a value'
