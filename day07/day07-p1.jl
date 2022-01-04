using DelimitedFiles
using Statistics
# Read in the data
positions = vec(readdlm("input.txt", ',', Int))
# Get the median
centre_point = median(positions)
# Print result
println(sum(abs.(positions .- centre_point)))