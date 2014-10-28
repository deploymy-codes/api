module DeployMyCodes
  class Biz < SimpleDelegator

    class << self
      def wrap(models, associations)
        models.respond_to?(:length) ? wrap_multi(models, associations) : wrap_unique(models, associations)
      end

      private

      def wrap_unique(model, associations)
        biz = "Biz::#{model.class.name}".constantize.new model
        biz.wrap_associations associations

        biz
      end

      def wrap_multi(models, associations)
        models.map { |model| wrap_unique model, associations }
      end
    end

    def data
      self.__getobj__
    end

    def wrap_associations(associations)
      associations.each(&method(:wrap_assocation))
    end

    def wrap_assocation(association)
      models = biz.data.send(association)

      define_method(association) do
        self.class.wrap(models)
      end
    end

  end
end
