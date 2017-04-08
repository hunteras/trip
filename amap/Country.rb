require 'http'
require 'json'

class Country
	@@url_pattern = 'http://restapi.amap.com/v3/config/district?keywords=%s&subdistrict=%d&key=83f7d87525845404326fc2f903234cf9'

	def province()
		return take('中国', 1)
	end

	def cities(depth)
		return take('中国', depth)
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