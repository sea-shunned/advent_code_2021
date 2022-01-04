using DelimitedFiles
# Get the path to the input
input_path = joinpath(pwd(), "input.txt")
# Load the input
depths = readdlm("$input_path", '\n', Int)
# Counter for increases
global num_increases = 0
# Extract the first depth
global prev = depths[1]
# Loop over the depths
for val in depths[2:end]
    if val > prev
        global num_increases += 1
    end
    global prev = val
end
println(num_increases)