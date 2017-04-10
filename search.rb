
def tree_search(states, goal_p, successors, combiner)
    puts "#{states}"
    case
    when states.empty? 
        false
    when goal_p.call(states.first)
        states.first
    else
        tree_search(combiner.call(successors.call(states.first), 
                                states.drop(1)),
                    goal_p, successors, combiner)
    end
end

def depth_first_search(start, goal_p, successors)
    tree_search([].push(start), goal_p, successors, lambda {|a, b| a + b})
end

def binary_tree
    lambda {|x| [x*2, x*2+1]}
end

def is(value)
    lambda {|x| x==value}
end

# this find no result
# depth_first_search(1, is(12), binary_tree)

def prepend(x, y)
    y+x
end

def breadth_first_search(start, goal_p, successors)
    tree_search([].push(start), goal_p, successors, lambda {|a, b| b + a})
end

# breadth_first_search(1, is(12), binary_tree)

def finite_binary_tree(n)
    lambda {|x| binary_tree.call(x).reject {|child| child > n}}
end

# depth_first_search(1, (is 12), finite_binary_tree(15))

def diff(n)
    lambda {|x| (x - n).abs }
end

def sorter(cost_fn)
    # Return a combiner function that sorts according to cost_fn
    # new and old is array
    lambda {|a, b| (a + b).sort{|x, y| cost_fn.call(x) <=> cost_fn.call(y)} } 
end

def best_first_search(start, goal_p, successors, cost_fn)
    tree_search([].push(start), goal_p, successors, sorter( cost_fn ))
end

# best_first_search(1, is(12), binary_tree, diff(12))

def price_is_right(price)
    lambda { |x| 
        if x > price
            100**100 # a number forged as very large
        else
            price - x
        end
     }
end

# best_first_search(1, is(12), binary_tree, price_is_right(12))

def beam_search(start, goal_p, successors, cost_fn, beam_width)
    tree_search([].push(start), goal_p, successors,
        lambda {|old, new| 
            sorted = sorter(cost_fn).call(old, new)
            if beam_width > sorted.length
                sorted
            else
                sorted[0..beam_width-1]
            end
            })
end

# beam_search(1, is(12), binary_tree, price_is_right(12), 2)

require_relative 'amap/country'

CITIES = Country.new.province_capitals

class City
    def initialize()
    end
end