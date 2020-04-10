# frozen_string_literal: true

class IntClosedSection
  attr_reader :lower_limit
  attr_reader :upper_limit

  def initialize(lower_limit:, upper_limit:)
    @lower_limit = lower_limit
    @upper_limit = upper_limit
  end
end

class WrongRangeError < StandardError

end