require_relative '../../snap_ci'

module Lita
  module Handlers
    class SnapCi < Handler
      config :user, type: String, required: true
      config :token, type: String, required: true
      config :projects, type: Array, required: true

      route(/^snap-ci\s+report$/,
            :all_projects,
            help: { t('report.command') => t('report.desc') })

      def all_projects(response)
        response.reply ::SnapCi::ProjectList.new(config).to_message
      end

      route(/^snap-ci\s+project\s+(.+)$/,
            :project,
            help: { t('project.command') => t('project.desc') })

      # Return the first match, for an exact match use owner/repository format
      def project(response)
        format = if response.args[1].slice("/").nil?
                   :repo
                 else
                   :owner
                 end

        project_arg = config.projects.detect do |project|
          if format == :owner
            project[:owner] == response.args[1].partition("/").first &&
              project[:repository] == response.args[1].partition("/").last
          else
            project[:repository] == response.args[1]
          end
        end

        response.reply ::SnapCi::Project.new(project_arg, config).to_message
      end

      Lita.register_handler(self)
    end
  end
end
