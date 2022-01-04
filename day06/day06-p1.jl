using DelimitedFiles
# Load the input
fishes = vec(readdlm("input.txt", ',', Int))
# Number of days to simulate
NUM_DAYS = 80
# Simulate it
for day in 1:NUM_DAYS
    for i in 1:length(fishes)
        if fishes[i] == 0
            push!(fishes, 8)
            fishes[i] = 6
        else
            fishes[i] -= 1
        end
    end
    # println(fishes)
end
println(length(fishes))