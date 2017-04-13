#!/usr/bin/env ruby -I .

require_relative 'country'

class City
    attr_accessor :code, :name, :center, :province, :longitude, :latitude
    def initialize(h)
        h.each {|k,v| public_send("#{k}=",v)}
        (@longitude, @latitude) = @center.split(',').map{|s| s.to_f}
    end
end

def cities()
    Country.new.province_capitals.map {|c| City.new(c) }
end
