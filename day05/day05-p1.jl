# Read the input
input = readlines("sample.txt")
# Get the total number of lines
num_lines = size(split.(input))[1]
# Container for coordinates
raw_coords = zeros(Int, (num_lines, 4))
# Extract the coords (stitching together the tuples)
for (i, line) in enumerate(input)
    split_line = split(line)
    single_coords = parse.(Int, split(split_line[1] * "," * split_line[3], ','))
    raw_coords[i, :] = single_coords
end
# Account for 1-indexing
raw_coords .+= 1
# Initialize diagram - scale to the max/min xs and ys
diagram = zeros(
    Int,
    maximum(raw_coords[:, [1,3]])+1, #- minimum(raw_coords[:, [1,3]]),
    maximum(raw_coords[:, [2,4]])+1 #- minimum(raw_coords[:, [2,4]])
)
# Ensure coordinates are the right way around for indexing (i.e. x1 <= x2 & y1 <= y2)
coords = zeros(Int, (num_lines, 4))
# Do the xs
coords[:, 1] = minimum(raw_coords[:, [1,3]], dims=2)
coords[:, 3] = maximum(raw_coords[:, [1,3]], dims=2)
# Do the ys
coords[:, 2] = minimum(raw_coords[:, [2,4]], dims=2)
coords[:, 4] = maximum(raw_coords[:, [2,4]], dims=2)
# Loop over each line segment
for coord_line in eachslice(coords, dims=1)
    # Extract coords for readability
    x1, y1, x2, y2 = coord_line
    # Part 1: horizontal and vertical lines only
    if (x1 == x2) || (y1 == y2)
        # y1 and x1 need to always be smaller than their counterparts
        diagram[y1:y2, x1:x2] .+= 1
    else
        continue
    end
end

display(diagram)
println('\n',sum(diagram .>= 2))