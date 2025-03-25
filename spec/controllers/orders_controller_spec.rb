# spec/controllers/orders_controller_spec.rb
require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe 'POST #create' do
    let(:product) do 
      Product.create!(
        name: 'Test Product', 
        price: 10.00
      ) 
    end

    context 'with valid parameters' do
      let(:valid_params) do
        {
          product_id: product.id,
          email: 'user@example.com',
          name: 'John Doe',
          quantity: 1
        }
      end

      it 'creates a new order' do
        expect {
          post :create, params: valid_params
        }.to change(Order, :count).by(1)
      end

      it 'returns the order in the response' do
        post :create, params: valid_params
        expect(JSON.parse(response.body)['order']).to be_present
      end
    end

    context 'with invalid parameters' do
      context 'when product does not exist' do
        it 'returns not found status' do
          post :create, params: { product_id: 0, email: 'user@example.com', name: 'John Doe', quantity: 1 }
          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)['errors']).to be_present
        end
      end

      context 'when quantity is invalid' do
        it 'returns unprocessable entity status' do
          post :create, params: { 
            product_id: product.id, 
            email: 'user@example.com', 
            name: 'John Doe', 
            quantity: 0 
          }
          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)['errors']).to be_present
        end
      end
    end
  end
end

