class Route
  def initialize(route_details)
    @path = route_details.first
    @controller_name = route_details.last[:controller]
    @instruction = route_details.last[:method]
    require_controller
  end 

  def require_controller
    require controller_name.downcase 
  end

  def controller 
    Module.const_get(controller_name)
  end

  def execute(env)
    controller.new(env).send(instruction.to_sym)
  end

  private
  attr_accessor :controller_name, :instruction
end
