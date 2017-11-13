require 'rack/test'
require 'json'

require_relative '../../app/api'

module ExpenseTracker
  RSpec.describe 'Expense Tracker API' do
    include Rack::Test::Methods

    def post_expense(expense)
      post '/expenses', JSON.generate(expense)
      expect(last_response.status).to eq(200)

      parsed = JSON.parse(last_response.body)

      expect(parsed).to include('expense_id' => a_kind_of(Integer))
      expense.merge('id' => parsed['expense_id'])
    end

    def app
      ExpenseTracker::API.new
    end

    it 'records submitted expenses' do
      pending 'Need to persist expenses'
      coffee = post_expense(
        'payee' => 'Market Lane Coffee',
        'amount' => 4.8,
        'date' => '2017-06-10'
      )

      commute = post_expense(
        'payee' => 'PTV',
        'amount' => 7.8,
        'date' => '2017-06-10'
      )

      groceries = post_expense(
        'payee' => 'Woolie',
        'amount' => 70.99,
        'date' => '2017-11-11'
      )

      get '/expenses/2017-06-10'

      expect(last_response.status).to eq(200)

      expenses = JSON.parse(last_response.body)

      expect(expenses).to contain_exactly(coffee, commute)
    end
  end
end
