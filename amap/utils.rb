#!/usr/bin/env ruby -I .
# coding: utf-8
require 'http'
require 'json'

require_relative 'setting'
require_relative 'city'

module Utils
    include Setting
    
    def Utils.distance(city_a, city_b)
        url = "http://restapi.amap.com/v3/distance?key=#{Key}&origins=#{city_a.longitude},#{city_a.latitude}&destination=#{city_b.longitude},#{city_b.latitude}"
        raw = JSON.parse(HTTP.get(url).body)
        return raw['results'].first['distance'].to_i
    end
end
