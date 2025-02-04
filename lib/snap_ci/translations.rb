require 'i18n'

module SnapCi
  module Translations
    module ClassMethods
      def t(key, hash = {})
        I18n.t("lita.handlers.snap_ci.#{key}", hash)
      end
    end

    module InstanceMethods
      private

      def t(key, hash = {})
        self.class.t(key, hash)
      end
    end

    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods
    end
  end
end
