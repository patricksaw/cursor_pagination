require "cursor_pagination/version"
require "cursor_pagination/active_record_extension"
require 'cursor_pagination/action_view_helper'

module CursorPagination
  ::ActiveRecord::Base.send(:include, CursorPagination::ActiveRecordExtension)

  class Cursor
    attr_reader :cursor

    def initialize(cursor)
      @cursor = cursor
    end

    def self.decode(cursor)
      unless cursor.nil?
        new YAML.load(Base64.strict_decode64(cursor))
      else
        new nil
      end
    end

    def encoded
      Base64.strict_encode64 cursor.to_yaml
    end

    def empty?
      cursor.nil? || invalid?
    end

    def invalid?
      cursor == -1
    end

    def value
      @cursor
    end

    def to_s
      cursor.nil? ? nil : encoded
    end
  end
end
