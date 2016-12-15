
def parseBotInstruction(string)
  m = string.match('bot (\d+) gives low to (.+) (\d+) and high to (.+) (\d+)')
  ["bot" + m[1], {:low => m[2]+m[3], :high => m[4]+m[5]}]
end

def parseValueInstruction(string)
  m = string.match('value (\d+) goes to bot (\d+)')
  ["bot" + m[2], m[1].to_i]
end

def groupLines(lines)
  lines.group_by { |x| x.slice(0, 3) }
end

def processInstructions(instructions)
  group = groupLines(instructions)
  valueInstructions = toValueInstructions(group["val"])
  botInstructions = toBotInstructions(group["bot"])
  model = processValueInstructions(valueInstructions)
  processBotInstructions(model, botInstructions)
end

def toValueInstructions(valInstructions)
  valInstructions.map { |x| parseValueInstruction(x) }
end

def toBotInstructions(botInstructions)
  botInstructions.map { |x| parseBotInstruction(x) }
end

def processValueInstructions(instructions)
  instructions.reduce(Hash.new) { |acc, x|
    botId = x[0]
    bot = acc.fetch(botId, [botId, []])
    bot[1] += [x[1]]
    acc[botId] = bot
    acc
  }
end

def processBotInstructions(model, instructions)
  changed = true
  while changed do
    changed = false
    model = instructions.reduce(model) { |acc, x|
      botId = x[0]
      bot = acc[botId]
      if (bot != nil && bot[1].size == 2)
        x_high = x[1][:high]
        x_low = x[1][:low]
        highBot = acc.fetch(x_high, [x_high, []])
        highBot[1] += [bot[1].max]
        lowBot = acc.fetch(x_low, [x_low, []])
        lowBot[1] += [bot[1].min]
        acc[x_high] = highBot
        acc[x_low] = lowBot
        changed = true
        if (bot[1] & [61, 17]).size == 2
          puts "Answer: " + bot.to_s
        end
        bot[1].clear
      end
      acc
    }
  end
  model
end
