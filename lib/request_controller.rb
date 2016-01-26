require "router"

class RequestController
  def initialize
    @router = Router.new
  end

  def call(env)
    route = @router.get_route_for(env)
    if route
      response = route.execute(env)
      return response.rack_response
    else
      return [404, {}, []]
    end
  end
end
