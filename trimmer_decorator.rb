# frozen_string_literal: true

require './base_decorator'

class TrimmerDecorator < BaseDecorator
  def correct_name
    super[0..9]
  end
end
