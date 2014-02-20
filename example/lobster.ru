require 'rack/lobster'

module Rack
  class Color
    def initialize app
      @app = app
    end

    def call env
      status, headers, body = @app.call(env)

      req = Request.new env
      body.write '<style type="text/css">'
      body.write  case req.GET['color']
                  when 'blue' then 'body { background: blue }'
                  when 'red'  then 'body { background: red  }'
                  end

      body.write '</style>'

      [status, headers, body]
    end
  end
end

use Rack::Color
use Rack::ShowExceptions
run Rack::Lobster.new
