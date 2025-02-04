require_relative 'project'

module SnapCi
  class ProjectList
    attr_reader :list

    def initialize(args)
      @list = []
      mutex = Mutex.new

      args.projects.map do |project_info|
        Thread.new do
          project_message = Project.new(project_info, args).to_message
          mutex.synchronize { @list << project_message }
        end
      end.each(&:join)
    end

    def to_message
      list.join("\n\n")
    end
  end
end
