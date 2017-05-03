# frozen_string_literal: true
require_relative 'spec_helper'

describe XBee do
	specify { XBee::VERSION.should_not be_nil }
end
