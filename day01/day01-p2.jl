using DelimitedFiles
# Get the path to the input
input_path = joinpath(pwd(), "input.txt")
# Load the input
depths = readdlm("$input_path", '\n', Int)
# Get all 3-tuples
combs = zip(depths[1:end-2], depths[2:end-1], depths[3:end])
# Sum each 3ple
sums = [a+b+c for (a,b,c) ∈ combs]
# Count the number of diffs > 0
num_increases = sum(diff(sums) .> 0)
println(num_increases)