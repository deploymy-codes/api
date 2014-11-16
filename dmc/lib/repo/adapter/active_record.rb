require 'active_record'

class Repo
  module Adapter
    class ActiveRecord

      def initialize
      end

      def create(object)
        object.save
      end

      def update(object)
        object.save
      end

      def clear
      end

      def query(klass, selector)
        if query_implemented? klass, selector
          send query_method(klass, selector), klass, selector
        else
          raise QueryNotImplementedError, selector
        end
      end

      private

      def query_method(klass, selector)
        "query_#{selector.class.name.demodulize.underscore}"
      end

      def query_implemented?(klass, selector)
        respond_to? query_method(klass, selector)
      end

    end
  end
end
