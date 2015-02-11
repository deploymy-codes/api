require 'perpetuity'

class Repository
  module Adapter
    class Perpetuity

      def first(klass)
        mapper_for(klass).first
      end

      def all(klass)
        mapper_for(klass).all.to_a
      end

      def count(klass)
        mapper_for(klass).count
      end

      def find(klass, id)
        entity = mapper_for(klass).find id

        raise EntityNotFoundError.new(klass, id) unless entity

        entity
      end

      def create(entity)
        mapper_for(entity.class).insert entity
      end

      def update(entity)
        mapper_for(entity.class).save entity
      end

      def delete(entity)
        mapper_for(entity.class).delete entity
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

      def mapper_for(klass)
        ::Perpetuity[klass]
      end

    end
  end
end
