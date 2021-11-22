require 'singleton'

class IOAdapter
    include Singleton

    def write(string)
        puts string
    end

    def read
        gets.chomp
    end
end