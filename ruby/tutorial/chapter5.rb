class Car

    @@makes = []
    @@cars = {}

    attr_reader :make

    def self.total_count
        @total_count ||= 0
    end

    def self.total_count=(n)
        @total_count = n
    end

    def self.add_make(make)
        unless @@makes.include?(make)
            @@makes << make
            @@cars[make] = 0
        end
    end

    def initialize(make)
        if @@makes.include?(make)
            puts "creating a new #{make}!"
            @make = make
            @@cars[make] += 1
            self.class.total_count += 1
        else
            raise "No Such make: #{make}"
        end
    end

    def make_mates
        @@cars[self.make]
    end
end

class Hybrid < Car
end

Car.add_make("Honda")
Car.add_make("Ford")

h3 = Hybrid.new("Honda")
f2 = Hybrid.new("Ford")

puts "THere are #{Hybrid.total_count} hybrids on the road"

# private methods..

class Cake
    def initialize(batter)
        @batter = batter
        @baked = true
    end
end

class Egg
end

class Flour
end

class Baker
    def bake_cake
        @batter = []
        pour_flour
        add_egg
        stir_batter
        return Cake.new(@batter)
    end

    def add_egg
        @batter.push(Egg.new)
    end

    def pour_flour
        @batter.push(Flour.new)
    end

    def stir_batter
    end

    # 声明私有方法
    private :pour_flour, :add_egg, :stir_batter
end

