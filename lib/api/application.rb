# frozen_string_literal: true
require 'sinatra'
require 'logger'
require 'api/commands'
require 'commands'
require 'handlers'

module Api
  class Application < Sinatra::Base
    use Rack::CommonLogger, Logger.new(STDOUT)

    post '/commands/dogs/:aggregate_id/:command_type' do |aggregate_id, command_type|
      logger.info "aggregate_id=#{aggregate_id} command_type=#{command_type}"
      Api::Commands.execute(::Commands::Dog, command_type, aggregate_id, request_json)
      respond_with_json(201, {})
    end

    get '/api/events/alpha' do
      # after = Integer(params.fetch('after'))
      # limit = Integer(params.fetch('limit'))
      # data = Queries::Events.all_after(after: after, limit: limit)
      # respond_with_json(200, { data: data })
    end

    # healthcheck
    get '/status' do
      respond_with_json(200, { hello: :world })
    end

    private

    def request_json
      @request_json ||= JSON.parse(request_body)
    end

    def request_body
      @request_body ||= request.body.read
    end

    def respond_with_json(status, body)
      [status, { 'Content-Type' => 'application/json' }, body.to_json]
    end
  end
end
