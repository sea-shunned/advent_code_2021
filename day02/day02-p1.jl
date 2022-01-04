using DelimitedFiles
# Initialize vars
hor_pos = 0
depth = 0
# Define movement functions
move_forward(hor_pos, X) = hor_pos + X
move_down(depth, X) = depth + X
move_up(depth, X) = depth - X
# Loop over inputs
for input_line in readdlm(joinpath(pwd(), "input.txt"), '\n')
    command, X = split(input_line, " ")
    X = parse(Int, X)
    # Use function for defined command
    if command == "down"
        global depth = move_down(depth, X)
    elseif command == "up"
        global depth = move_up(depth, X)
    elseif command == "forward"
        global hor_pos = move_forward(hor_pos, X)
    end
end
# Print multiplied result
println(hor_pos * depth)