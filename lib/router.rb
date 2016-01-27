require "route"

class Router
  def initialize
    @routes = Hash.new { |hash, key| hash[key] = [] }
    initialize_routes do 
      get("/test", :to => "custom#index")
      get(/.*/, :to => "custom#show")
    end
  end

  def initialize_routes(&block)
    instance_eval(&block)
  end

  def get(path, options)
    @routes[:get] << [path, parse_to(options[:to])]
  end

  def get_route_for(env)
    request_method = env["REQUEST_METHOD"].downcase.to_sym
    path = env["PATH_INFO"] 
    route_details = routes[request_method].find do |route|
      case route.first
      when String
        path == route.first
      when Regexp
        path =~ route.first
      end
    end
    return Route.new(route_details) if route_details
    return nil 
  end

  private
  attr_accessor :routes

  def parse_to(to_string)
    controller, method = to_string.split("#")
    {:controller => controller.capitalize, :method => method}
  end
end
