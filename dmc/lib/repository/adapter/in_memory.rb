class Repository
  module Adapter
    class InMemory

      def initialize
        clear
      end

      def first(klass)
        all(klass).first
      end

      def all(klass)
        map_for_class(klass).values
      end

      def paginate(klass, offset, limit)
        all(klass).slice(offset, limit)
      end

      def count(klass)
        map_for_class(klass).count
      end

      def find(klass, id)
        entity = map_for_class(klass)[id.to_i]

        raise EntityNotFoundError.new(klass, id) unless entity

        entity
      end

      def create(entity)
        @counter = @counter + 1
        entity.id = @counter
        map_for(entity)[entity.id] = entity
      end

      def update(entity)
        map_for(entity)[entity.id] = entity
      end

      def delete(entity)
        map_for(entity).delete entity.id
      end

      def query(klass, selector)
        if query_implemented? klass, selector
          send query_method(klass, selector), klass, selector
        else
          raise QueryNotImplementedError, selector
        end
      end

      def clear
        @counter = 0
        @map = {}
      end

      private

      def query_method(klass, selector)
        "query_#{selector.class.name.demodulize.underscore}"
      end

      def query_implemented?(klass, selector)
        respond_to? query_method(klass, selector)
      end

      def map_for_class(klass)
        @map[key(klass)] ||= {}
      end

      def map_for(entity)
        map_for_class(entity.class)
      end

      def key(klass)
        if klass.superclass != Entity
          key(klass.superclass)
        else
          klass.to_s.to_sym
        end
      end

    end
  end
end
