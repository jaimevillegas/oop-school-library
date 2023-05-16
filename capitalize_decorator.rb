# frozen_string_literal: true

require './base_decorator'

class CapitalizeDecorator < BaseDecorator
  def correct_name
    super.capitalize
  end
end
