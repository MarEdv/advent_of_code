# initialState = ({
#  :steps => 0,
#  :elevator => 0,
#  :levels =>
#  [
#   [
#    {:type => "Generator", :material => "Promethium"},
#    {:type => "Microchip", :material => "Promethium"}
#   ].to_set,
#   [
#    {:type => "Generator", :material => "Cobalt"},
#    {:type => "Generator", :material => "Curium"},
#    {:type => "Generator", :material => "Ruthenium"},
#    {:type => "Generator", :material => "Plutonium"}
#   ].to_set,
#   [
#    {:type => "Microchip", :material => "Cobalt"},
#    {:type => "Microchip", :material => "Curium"},
#    {:type => "Microchip", :material => "Ruthenium"},
#    {:type => "Microchip", :material => "Plutonium"}
#   ].to_set,
#   [].to_set
#  ]
# })

# move = (
#   {
#     :elevator => 0,
#     :items => [{:type => "Microchip", :material => "Cobalt"}]
#   }
# )

def process(state)
  i = 0
  visitedStates = [].to_set
  queue = []
  s = state
  while !isFinished(s) do
    nextStates = nextValidStates(s).select { |x|
      !visitedStates.include?({:levels => x[:levels], :elevator => x[:elevator]})
    }
    queue.insert(0, *(nextStates.to_a))
    visitedStates.merge(nextStates.map { |x|
      {:levels => x[:levels], :elevator => x[:elevator]}
    })
    puts "steps: " + s[:steps].to_s + "; " + i.to_s #+ "; " + visitedStates.to_a.to_s
    s = queue.pop
    i += 1
  end
  s
end

def isFinished(state)
  state[:levels].slice(0,3).all? { |x| x.empty? }
end

def nextValidStates(state)
  nextMoves(state)
       .select { |move|
         isValid(state, move)
       }
       .map { |move|
         nextState(state, move)
       }
end

def nextState(state, move)
  levels = state[:levels].map { |x|
    Array.new(x.to_a).to_set
  }
  levels[move[:elevator]] += move[:items]
  levels[state[:elevator]] -= move[:items]
  ({:elevator => move[:elevator], :steps => state[:steps]+1, :levels => levels})
end

def nextMoves(state)
  elevator = [state[:elevator] + 1, state[:elevator] - 1].select {|x| x >= 0 && x <= 3}
  elevator.map { |elevator|
    level = state[:levels][state[:elevator]]
    itemsArray = level.to_a.combination(1).to_a + level.to_a.combination(2).to_a
    itemsArray.map { |items| ({:elevator => elevator, :items => items}) }
  }.flatten
end

def isValid(state, move)
  levelId = move[:elevator]
  levelIdFrom = state[:elevator]
  levelTo = [].to_set + state[:levels][levelId].to_set
  levelTo += move[:items].to_set
  levelFrom = [].to_set + state[:levels][levelIdFrom].to_set
  levelFrom -= move[:items].to_set
  isValidLevel(levelTo) && isValidLevel(levelFrom)
end

def isValidLevel(level)
  levelGroups = level.group_by {|x| x[:type] }
  if levelGroups["Microchip"] == nil
    true
  else
    levelGroups["Microchip"].all? { |chip|
      if (levelGroups["Generator"] == nil)
        true
      else
        gens = levelGroups["Generator"].group_by { |gen|
          gen[:material] == chip[:material]
        }
        (gens[true] != nil && gens[true].size == 1) || (gens[false] == nil || gens[false].size == 0)
      end
    }
  end
end
