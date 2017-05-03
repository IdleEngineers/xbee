# frozen_string_literal: true

module XBee
	module Exceptions
		# Base class for all XBee exception types, for convenience when consumer code wants to rescue anything XBee raises.
		class Exception < RuntimeError
		end
	end
end
