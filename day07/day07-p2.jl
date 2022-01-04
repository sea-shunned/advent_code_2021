using DelimitedFiles
using Statistics
# Read in the data
positions = vec(readdlm("input.txt", ',', Int))
# Get the initial centre point from the mean
init_centre_point = round(mean(positions))
# Container for best found
best_fuel = Inf
# Search around the mean (it has to be close)
for centre_point ∈ init_centre_point-1:init_centre_point+1
    # Local fuel value
    fuel = 0
    # Loop over the input positions
    for i ∈ positions
        # Add the increasing fuel cost
        fuel += sum(collect(1:abs(i-centre_point)))
    end
    # Update fuel if better found
    if fuel < best_fuel
        global best_fuel = fuel
    end
end
println(Int(best_fuel))