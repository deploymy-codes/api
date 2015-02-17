class Repository
  module Adapter
    class Sequel

      def first(klass)
        build_entity klass, mapper_for(klass).first
      end

      def all(klass)
        build_entity klass, mapper_for(klass).all
      end

      def paginate(klass, offset, limit)
        build_entity klass, mapper_for(klass).limit(limit).offset(offset).all
      end

      def count(klass)
        mapper_for(klass).count
      end

      def find(klass, id)
        entity = build_entity klass, mapper_for(klass).first(id: id)

        raise EntityNotFoundError.new(klass, id) unless entity

        entity
      end

      def create(entity)
        id = mapper_for(entity.class).insert entity.attributes
        entity.id = id
      end

      def update(entity)
        mapper_for(entity.class).update entity.attributes
      end

      def delete(entity)
        mapper_for(entity.class).delete entity
      end

      def query(klass, selector)
        if query_implemented? klass, selector
          result = send query_method(klass, selector), klass, selector
          build_entity klass, result
        else
          raise QueryNotImplementedError, selector
        end
      end

      private

      def build_entity(klass, dataset)
        if dataset.is_a? Array
          dataset.map { |record| klass.new record }
        elsif dataset.is_a? Hash
          klass.new dataset
        end
      end

      def query_method(klass, selector)
        "query_#{selector.class.name.demodulize.underscore}"
      end

      def query_implemented?(klass, selector)
        respond_to? query_method(klass, selector)
      end

      def mapper_for(klass)
        DB[klass.name.demodulize.tableize.to_sym]
      end

    end
  end
end
