# frozen_string_literal: true

class SpotsController < ApplicationController
  def show
    result = ::Spots::Show.new(params).call

    return render json: result.success[:spots] if result.success?

    messages = result.failure.try(:messages)
    return render status: :unprocessable_entity, json: messages.to_json if messages.present?

    render status: result.failure[:errors][:status], json: result.failure.to_json
  end
end
