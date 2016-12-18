
def process(commands, registers)
  i = 0
  while i < commands.size do
    i += processCommand(commands[i].chomp, registers)
  end
  registers
end

def processCommand(command, registers)
  if command.start_with?("cpy")
    m = command.match('cpy (.+) (.+)')
    if registers.has_key?(m[1]) # copies from a register
      registers[m[2]] = registers[m[1]].to_i
    else
      registers[m[2]] = m[1].to_i
    end
    1
  elsif command.start_with?("jnz")
    m = command.match('jnz (.+) ([-]?\d+)')
    if registers[m[1]] != 0
      m[2].to_i
    else
      1
    end
  elsif command.start_with?("inc")
    m = command.match('inc (.+)')
    registers[m[1]] = registers[m[1]] + 1
    1
  elsif command.start_with?("dec")
    m = command.match('dec (.+)')
    registers[m[1]] = registers[m[1]] - 1
    1
  end
end
