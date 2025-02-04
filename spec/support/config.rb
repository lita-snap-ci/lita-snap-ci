module Config
  def load_config
    registry.config.handlers.snap_ci.user = "snapUser"
    registry.config.handlers.snap_ci.token = "Snap-ci-api-key"
    registry.config.handlers.snap_ci.projects = [
      {
        owner: 'oneorg',
        repository: 'api',
        branches: ['development', 'staging', 'master']
      },{
        owner: 'oneorg',
        repository: 'front',
        branches: ['staging', 'master']
      },{
        owner: 'otherorg',
        repository: 'websites',
        branches: ['develop' , 'master']
      }
    ]
  end

  def load_wrong_config
    registry.config.handlers.snap_ci.user = "snapUser"
    registry.config.handlers.snap_ci.token = "Snap-ci-api-key"
    registry.config.handlers.snap_ci.projects = [
      {
        owner: 'wrong_org',
        repository: 'wrong_project',
        branches: ['wrong_branch']
      }
    ]
  end
end
