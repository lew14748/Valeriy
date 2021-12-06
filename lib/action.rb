require_relative 'valera'

class Action
  attr_reader :action, :valera, :field, :value, :operator

  def initialize(action, valera)
    @action = action
    @valera = valera
    @field = @action['conds'][0]['field']
    @value = @action['conds'][0]['value']
    @operator = @action['conds'][0]['operator']
  end

  def do_action
    do_effect if conds_correct?
  end

  def do_effect
    (0...@action['effects'].size).each do |i|
      field_effect = @action['effects'][i]['field']
      operator_effect = @action['effects'][i]['operator']
      value_effect = @action['effects'][i]['value']
      @valera.send "#{field_effect}=", change_value(@valera.send(field), operator_effect, value_effect)
    end
  end

  def change_value(value_before, operator, value)
    case operator
    when '+'
      value_after = value_before + value
    when '-'
      value_after = value_before - value
    end
  end

  def conds_correct?
    case @operator
    when '='
      @valera.send(@field) == @value
    when '>'
      @valera.send(@field) > @value
    when '<'
      @valera.send(@field) < @value
    end
  end
end
