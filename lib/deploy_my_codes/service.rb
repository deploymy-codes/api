module DeployMyCodes
  class Service < Struct.new(:params)

    def self.call(params = {})
      new(params).call
    end

    def repository
      @repository ||= ActiveRecordRepository.new
    end

  end
end
