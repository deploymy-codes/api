require 'active_record'

class Repository
  module Adapter
    class ActiveRecord

      def initialize
        ::ActiveRecord.establish_connection
      end

      def all(klass)
        models_for_class(klass).all
      end

      def count(klass)
        models_for_class(klass).count
      end

      def find(klass, id)
        record = models_for_class(klass).find id

        raise RecordNotFoundError.new(klass, id) unless record

        record
      end

      def create(record)
        to_model(record).save
      end

      def update(record)
        record.save
      end

      def delete(record)
        record.destroy
      end

      def empty?(klass)
        all(klass).empty?
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

      def to_model(record)
        model_for_class(record.class).new record.attributes
      end

      def model_for_class(klass)
        "ActiveRecord::#{klass.name.demodulize}".constantize
      end

    end
  end
end
