# frozen_string_literal: true

class IntClosedSection
  attr_reader :lower_limit
  attr_reader :upper_limit

  def initialize(lower_limit:, upper_limit:)
    raise WrongTypeInputError unless lower_limit.kind_of?(Integer) && upper_limit.kind_of?(Integer)
    raise WrongRangeInputError if lower_limit > upper_limit

    @lower_limit = lower_limit
    @upper_limit = upper_limit
  end

  def to_s
    "[#{lower_limit},#{upper_limit}]"
  end

  def include_int?(num)
    raise WrongTypeInputError unless num.kind_of?(Integer)

    (lower_limit..upper_limit).include?(num)
  end

  def include_section?(section)
    raise WrongTypeInputError unless section.kind_of?(IntClosedSection)

    (lower_limit..upper_limit).cover?(section.lower_limit..section.upper_limit)
  end

  def === (other)
    return false unless other.kind_of?(IntClosedSection)
    lower_limit == other.lower_limit && upper_limit == other.upper_limit
  end

  def equal_to?(section)
    self === section
  end
end
