require "byebug"
class Employee
  attr_reader :salary
  def initialize(name, title, salary, boss = nil)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    bonus = salary * multiplier
  end

  def boss=(boss_object)
    @boss = boss_object
  end

  # def get_sub_salaries
  #   @salary
  # end
end

class Manager < Employee
  attr_reader :subordinates
  def initialize(name, title, salary, boss = nil)
    super(name, title, salary, boss)
    @subordinates = []
  end

  def subordinates=(sub_object)
    @subordinates << sub_object
  end

  def bonus(multiplier)
    # byebug
    bonus = get_sub_salaries * multiplier
  end

  def get_sub_salaries

    total_sal = 0
    @subordinates.each do |subord|
      if subord.class == Employee
        total_sal += subord.salary
      else
        total_sal += subord.get_sub_salaries + subord.salary
      end
    end
    total_sal
  end

end

ned = Manager.new("Ned", "Founder", 1_000_000)
ta_manager = Manager.new("Darren", "TA Manager", 78_000, ned)
ta1 = Employee.new("Shawna", "TA", 12_000, ta_manager)
ta2 = Employee.new("David", "TA", 10_000, ta_manager)

ned.subordinates = ta_manager
ta_manager.subordinates = ta1
ta_manager.subordinates = ta2

p ned.bonus(5)
p ta_manager.bonus(4)
p ta2.bonus(3)
