# Abstract Factory Pattern

class DepartmentFactory
  def create_department(name)
    raise NotImplementedError, "Subclasses must implement this method"
  end
end

class HRDepartmentFactory < DepartmentFactory
  def create_department(name)
    HRDepartment.new(name)
  end
end

class EngineeringDepartmentFactory < DepartmentFactory
  def create_department(name)
    EngineeringDepartment.new(name)
  end
end

# Factory Method Pattern

class Department
  attr_accessor :name, :head, :employee_count

  def initialize(name)
    @name = name
    @head = nil
    @employee_count = 0
  end
end

class HRDepartment < Department
end

class EngineeringDepartment < Department
end

# Decorator Pattern

class DepartmentDecorator
  attr_reader :department

  def initialize(department)
    @department = department
  end
end

class DepartmentHeadDecorator < DepartmentDecorator
  attr_accessor :head

  def initialize(department, head)
    super(department)
    @head = head
  end
end

# Observer Pattern

class DepartmentObserver
  def update(department, message)
    raise NotImplementedError, "Subclasses must implement this method"
  end
end

class EmployeeCountObserver < DepartmentObserver
  def update(department, message)
    puts "#{department.name} department employee count: #{department.employee_count}"
  end
end

class Department
  attr_accessor :name, :head, :employee_count

  def initialize(name)
    @name = name
    @head = nil
    @employee_count = 0
    @observers = []
  end

  def add_observer(observer)
    @observers << observer
  end

  def remove_observer(observer)
    @observers.delete(observer)
  end

  def notify_observers(message)
    @observers.each { |observer| observer.update(self, message) }
  end
end

# Usage

hr_factory = HRDepartmentFactory.new
engineering_factory = EngineeringDepartmentFactory.new

hr_department = hr_factory.create_department('HR')
engineering_department = engineering_factory.create_department('Engineering')

hr_department.add_observer(EmployeeCountObserver.new)
engineering_department.add_observer(EmployeeCountObserver.new)

hr_department.employee_count = 10
hr_department.notify_observers('Employee count updated')

engineering_department.employee_count = 50
engineering_department.notify_observers('Employee count updated')
