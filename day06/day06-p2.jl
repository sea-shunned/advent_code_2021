using DelimitedFiles
# Load the input
fishes = vec(readdlm("input.txt", ',', Int))
# Create counter for number of fish at each day
fish_count = zeros(Int, 9)
# Add the starting fish
for i in fishes
    fish_count[i+1] += 1
end
# Number of days to simulate
NUM_DAYS = 256
# Simulate it
for day in 1:NUM_DAYS
    # Extract how many are at 0, i.e. will reproduce
    num_reproducing = fish_count[1]
    # Loop over the fish and update counts
    for i in 1:length(fish_count)-1
        fish_count[i] = fish_count[i+1]
    end
    # Set the new day 8s as the number that are reproducing
    fish_count[end] = num_reproducing
    # Add the reproducing fish to day 6
    fish_count[7] += num_reproducing
end
println(sum(fish_count))