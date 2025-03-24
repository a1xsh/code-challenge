class BaseController < ApplicationController
  def create
    data = resource_class::Create.call(resource_params)
    handle_entity_result(data, :ok)
  end

  private

  def resource_class
    controller_name.classify.constantize
  end
  
  def resource_params; end
end
