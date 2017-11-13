require 'rack/test'
require 'json'

module ExpenseTracker
  RSpec.describe 'Expense Tracker API' do
    include Rack::Test::Methods

    it 'records submitted expenses' do
      coffee = {
        'payee' => 'Market Lane Coffee',
        'amount' => 4.8,
        'date' => '2017-06-10'
      }

      post '/expenses', JSON.generate(coffee)
    end
  end
end
