# coding: utf-8
require 'http'
require 'json'
require_relative 'setting'

class Country
    include Setting
    @@url_pattern = 'http://restapi.amap.com/v3/config/district?keywords=%s&subdistrict=%d&key='+Key

    def province()
	return take('中国', 1)
    end

    def cities(depth)
	return take('中国', depth)
    end

    def province_capitals()
        capitals = []
        raw = take('中国', 2)
        provinces = raw['districts'].first['districts']
        provinces[0..-4].each do |p|
            p['districts'].each do |c|
                capitals.push({
                                  'code' => c['citycode'], 
                                  'name' => c['name'],
                                  'center' => c['center'],
                                  'province' => p['name'],
                              })
            end
        end
        provinces[-3..-1].each do |p|
            capitals.push({
                              'code' => p['citycode'], 
                              'name' => p['name'],
                              'center' => p['center'],
                              'province' => p['name'],
                          })
        end
        return capitals
    end

    private
    def get(url)
	return HTTP.get(url).body
    end

    def take(key, depth)
	url = sprintf(@@url_pattern, key, depth)
	return JSON.parse(get(url))
    end
end

def Country_Usage()
    c = Country.new()
    cities = c.cities(2)
    puts cities
end
