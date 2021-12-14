require_relative 'valera'

class Action
  attr_reader :action, :valera

  def initialize(action, valera)
    @action = action
    @valera = valera
  end

  def do_action
    do_effect if conds_correct?
  end

  def do_effect
    (@action['effects']).all? do |effect|
      field = effect['field']
      value = effect['value']
      operator = effect['operator']
      @valera.send "#{field}=", change_value(@valera.send(field), operator, value)
    end
  end

  def change_value(value_before, operator, value)
    value_before.send(operator, value)
  end

  def conds_correct?
    (@action['conds']).all? do |cond|
      field = cond['field']
      value = cond['value']
      operator = cond['operator']
      @valera.send(field).send(operator, value)
    end
  end
end
