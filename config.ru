# frozen_string_literal: true

$LOAD_PATH.unshift('./lib')
require 'api/application'

run Api::Application
