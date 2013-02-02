expect = chai.expect

describe "app", ->
  it "it has a start method", ->
    app = require 'app'
    expect(app.start).to.be.a('function')

  it "can use sinon spies", ->
    fn = (callback) ->
      callback()

    cb = sinon.spy()
    fn(cb)
    expect(cb).to.have.been.called

