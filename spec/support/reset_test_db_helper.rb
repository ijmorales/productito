require 'json'

module ResetTestDbHelper
  def reset_test_db
    dummy_data = [
      { "price": 1.99, "name": 'Orange', "id": 1 },
      { "price": 3.32, "name": 'Apple', "id": 8 }
    ]

    File.write('db/test/products.json', JSON.pretty_generate(dummy_data))
  end
end
