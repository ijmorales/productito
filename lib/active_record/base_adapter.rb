class ActiveRecord
  class BaseAdapter
    def initialize(model)
      @model = model
    end

    def all; end

    def save(record); end

    def create(params); end

    private

    def model_name
      @model.name
    end
  end
end
