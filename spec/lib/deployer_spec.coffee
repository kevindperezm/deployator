Deployer = require '../../lib/deployer'
options = {
  githubUser: 'kevindperezm',
  githubRepo: 'hellocat',
  githubToken: '6a31272a5b85e5936254ebd18a0e4ea31867c8b5',
  herokuApp: 'hellocat',
  herokuToken: 'fc87fa24-4d8d-4073-94ca-4c0d09649e75'
}
badOptions = {
  githubUser: 'kevindperezm',
  githubRepo: 'hellocat',
  githubToken: 'fakeToken',
  herokuApp: 'hellocat',
  herokuToken: 'fakeToken2'
}
deployer = new Deployer(options)
badDeployer = new Deployer(badOptions)

describe 'The Deployer class', ->
  it 'has a deploy method', ->
    expect(deployer.deploy).toBeDefined()

  describe 'checks correctly for', ->
    it 'github user access', (done) ->
      deployer.checkGithubUserAccess (access, err) ->
        expect(access).toBe true

      badDeployer.checkGithubUserAccess (access, err) ->
        expect(access).toBe false
        expect(err).toEqual "Can't access GitHub user data!"
        done()

    it 'github repo access', (done) ->
      deployer.checkGithubRepoAccess (access, err) ->
        expect(access).toBe true

      badDeployer.checkGithubRepoAccess (access, err) ->
        expect(access).toBe false
        expect(err).toEqual "Can't access GitHub repo data!"
        done()

    it 'heroku app access', (done) ->
      deployer.checkHerokuAccess (access, err) ->
        expect(access).toBe true

      badDeployer.checkHerokuAccess (access, err) ->
        expect(access).toBe false
        expect(err).toEqual "Can't access Heroku app data!"
        done()

    it 'both GitHub and Heroku access within a single method', (done) ->
      deployer.checkForRequiredAccess (access, err) ->
        expect(access).toBe true

      badDeployer.checkForRequiredAccess (access, err) ->
        expect(access).toBe false
        done()

