require 'json'

class ActiveRecord
  class JsonAdapter < BaseAdapter
    def all
      data = JSON.parse(File.read(file_path))
      data.map { |record| @model.new(record) }
    end

    def save(record)
      records = all
      if record.id.nil?
        assign_new_id(record, records)
        records << record
      else
        update_existing_record(records, record)
      end
      persist_records(records)
    end

    private

    def file_path
      "db/#{model_name.downcase}s.json"
    end

    def model_name
      @model.name
    end

    def assign_new_id(record, records)
      record.id = records.empty? ? 1 : records.last.id + 1
    end

    def update_existing_record(records, record)
      index = records.index { |r| r.id == record.id }
      records[index] = record
    end

    def persist_records(records)
      File.write(file_path, records.to_json)
    end
  end
end