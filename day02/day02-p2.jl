using DelimitedFiles
# Define movement functions
function move_forward(hor_pos, depth, aim, X)
    hor_pos += X
    depth += aim * X
    return hor_pos, depth
end
move_down(aim, X) = aim + X
move_up(aim, X) = aim - X
# Overall func
function calc_movement()
    # Initialize vars
    hor_pos, depth, aim = 0, 0, 0
    # Loop over inputs
    for input_line in readdlm(joinpath(pwd(), "input.txt"), '\n')
        command, X = split(input_line, " ")
        X = parse(Int, X)
        # Use function for defined command
        if command == "down"
            aim = move_down(aim, X)
        elseif command == "up"
            aim = move_up(aim, X)
        elseif command == "forward"
            hor_pos, depth = move_forward(hor_pos, depth, aim, X)
        end
        # println(hor_pos, " ", depth, " ", aim)
    end
    return hor_pos, depth
end
# Get needed vars
hor_pos, depth = calc_movement()
# Print multiplied result
println(hor_pos * depth)