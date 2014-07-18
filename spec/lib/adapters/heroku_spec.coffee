HerokuAdapter = require '../../../lib/adapters/heroku'
options = {
  app: 'hellocat',
  token: 'fc87fa24-4d8d-4073-94ca-4c0d09649e75'
}
badOptions = {
  app: 'hellocat',
  token: 'fakeToken'
}
adapter = new HerokuAdapter(options)
badAdapter = new HerokuAdapter(badOptions)

describe 'The Heroku adapter', ->
  describe 'checks correctly for', ->
    it 'heroku app access', (done) ->
      adapter.checkAccess (access, err) ->
        expect(access).toBe true
        done()

  describe 'when there are access errors', ->
    describe 'returns a simple error message for access to', ->
      it 'heroku app', (done) ->
        badAdapter.checkAccess (access, err) ->
          expect(access).toBe false
          expect(err).toEqual "Can't access Heroku app data!"
          done()

  describe 'can tell if a Heroku app', ->
    it "exists", (done) ->
      adapter.appExists 'hellocat', (exists, err) ->
        expect(exists).toBe true
        done()

    it "doesn't exists", ->
      appName = 'hopefully-non-existent-app'
      adapter.appExists appName, (exists, err) ->
        expect(exists).toBe false
        expect(err).toEqual "Whoops! There's no '#{appName}' hosted at Heroku!"
        done()

