require_relative 'valera'

class Action
    attr_reader :action, :valera

    def initialize action, valera
        @action = action
        @valera = valera
    end

    def do_action
        do_effect if conds_correct?
    end

    def do_effect
        for i in (0...@action['effects'].size) do
          field_effect = @action['effects'][i]['field']
          operator_effect = @action['effects'][i]['operator']
          value_effect = @action['effects'][i]['value']
          @valera.send "#{field_effect}=", change_value(@valera.send(field_effect), operator_effect, value_effect)
        end
    end

    def change_value value_before, operator, value
        case operator
        when '+'
            value_before + value
        when '-'
            value_before - value
        end
    end

    def conds_correct?
      for i in (0...@action['conds'].size) do
        field = @action['conds'][i]['field']
        value = @action['conds'][i]['value']
        operator = @action['conds'][i]['operator']
        case operator
        when '='
            check = (@valera.send(field) == value)
        when '>'
          check = (@valera.send(field) > value)
        when '<'
          check = (@valera.send(field) < value)
        end
        return false if (!check)
      end
      check
    end
end
