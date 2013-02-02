expect = chai.expect

describe "app", ->
  it "it has a start method", ->
    app = require 'app'
    expect(app.start).to.be.a('function')
