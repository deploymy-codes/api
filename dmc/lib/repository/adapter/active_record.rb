require 'active_record'

class Repository
  module Adapter
    class ActiveRecord

      def initialize
        ::ActiveRecord.establish_connection
      end

      def all(klass)
        to_entities to_active_record_klass(klass).all
      end

      def count(klass)
        to_active_record_klass(klass).count
      end

      def find(klass, id)
        record = to_active_record_klass(klass).find id

        raise RecordNotFoundError.new(klass, id) unless record

        to_entity record
      end

      def create(entity)
        to_active_record(entity).save
      end

      def update(entity)
        to_active_record(entity).save
      end

      def delete(entity)
        to_active_record(entity).destroy
      end

      def empty?(klass)
        all(klass).empty?
      end

      def query(klass, selector)
        if query_implemented? klass, selector
          to_entities(send query_method(klass, selector), klass, selector)
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

      def to_active_record_klass(klass)
        "ActiveRecord::#{klass.name.demodulize}".constantize
      end

      def to_active_record(entity)
        Mapper::ActiveRecord.new(entity).map
      end

      def to_entity(record)
        Mapper::Entity.new(record).map
      end

      def to_entities(records)
        Array(records).map { |record| to_entity record }
      end
    end
  end
end
