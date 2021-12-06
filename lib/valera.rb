require_relative 'border_checker'

class Valera 
    attr_reader :money, :health, :fun, :mana, :fatigue

    def initialize(health: 100, mana: 0, fun: 0, money: 0, fatigue: 0)
        init_border_checkers
    
        self.health = health
        self.mana = mana
        self.fun = fun
        self.money = money
        self.fatigue = fatigue
      end
    
      def dead?
        health <= 0 || fun <= -10
      end
    
      def money=(val)
        check_result = @money_border_checker.check (val)
        @money = check_result[0]
        self.money = money - check_result[1] if check_result[1].positive?
      end

      def mana=(val)
        check_result = @default_border_checker.check (val)
        @mana = check_result[0]
        self.health = health - check_result[1] if check_result[1].positive?
      end
    
      def health=(val)
        @health = @default_border_checker.check(val)[0]
      end
    
      def fatigue=(val)
        @fatigue =  @default_border_checker.check(val)[0]
      end
    
      def fun=(val)
        @fun = @fun_border_checker.check(val)[0]
      end
    
      def init_border_checkers
        @default_border_checker = BorderChecker.new 0, 100
        @money_border_checker = BorderChecker.new 0, 10000
        @fun_border_checker = BorderChecker.new -10, 10
      end

end
