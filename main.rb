require_relative 'lib/states/welcome'
require_relative 'lib/context'

context = Context.new
context.initialise (
    AppStates::Welcome.new)
