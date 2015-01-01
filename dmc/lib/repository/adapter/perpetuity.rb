require 'perpetuity'

class Repository
  module Adapter
    class Perpetuity

      def all(klass)
        ::Perpetuity[klass].all
      end

      def count(klass)
        ::Perpetuity[klass].count
      end

      def find(klass, id)
        entity = ::Perpetuity[klass].find id

        raise EntityNotFoundError.new(klass, id) unless entity

        entity
      end

      def create(entity)
        ::Perpetuity[entity.class].insert entity
      end

      def update(entity)
        ::Perpetuity[entity.class].save entity
      end

      def delete(entity)
        ::Perpetuity[entity.class].delete entity
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
