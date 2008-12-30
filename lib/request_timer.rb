module RequestTimer
  module Dispatcher
    def start_timer
      $rails_request_timer = Time.now
    end
  end

  module Helper
    def request_time(text_to_wrap = nil)
      time = "%.5f" % (Time.now - $rails_request_timer) if $rails_request_timer
      host = `hostname`.chomp

      if text_to_wrap
        content_tag :span, text_to_wrap, :title => "#{time}s from #{host}", :id => '_rrt'
      else
        "<!-- Served fresh in #{time} seconds by #{host} -->"
      end
    end
  end

  def self.setup
    require 'dispatcher'
    require 'application_helper'

    ActionController::Dispatcher.class_eval do
      include RequestTimer::Dispatcher
      before_dispatch :start_timer
    end

    ApplicationHelper.send :include, RequestTimer::Helper
  end
end
