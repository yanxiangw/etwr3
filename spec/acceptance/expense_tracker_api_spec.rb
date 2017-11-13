require 'rack/test'
require 'json'

require_relative '../../app/api'

module ExpenseTracker
  RSpec.describe 'Expense Tracker API' do
    include Rack::Test::Methods

    def app
      ExpenseTracker::API.new
    end

    it 'records submitted expenses' do
      coffee = {
        'payee' => 'Market Lane Coffee',
        'amount' => 4.8,
        'date' => '2017-06-10'
      }

      post '/expenses', JSON.generate(coffee)

      expect(last_response.status).to eq(200)
    end
  end
end
