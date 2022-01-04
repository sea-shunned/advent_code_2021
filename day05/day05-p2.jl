# Read the input
input = readlines("input.txt")
# Get the total number of lines
num_lines = size(split.(input))[1]
# Container for coordinates
input_coords = zeros(Int, (num_lines, 4))
# Extract the input_coords (stitching together the tuples)
for (i, line) in enumerate(input)
    split_line = split(line)
    single_coords = parse.(Int, split(split_line[1] * "," * split_line[3], ','))
    input_coords[i, :] = single_coords
end
# Account for 1-indexing
input_coords .+= 1
# Initialize diagram - scale to the max/min xs and ys
diagram = zeros(
    Int,
    maximum(input_coords[:, [1,3]])+1, #- minimum(input_coords[:, [1,3]]),
    maximum(input_coords[:, [2,4]])+1 #- minimum(input_coords[:, [2,4]])
)
# Loop over each line segment
for coord_line in eachslice(input_coords, dims=1)
    # Extract coords for readability
    x1, y1, x2, y2 = coord_line
    # println("$x1, $y1, $x2, $y2")
    # Check if line is horizontal or vertical
    if (x1 == x2) || (y1 == y2)
        # y1 and x1 need to always be smaller than their counterparts, so TODO: need to sort that here
        diagram[
            max(y1:y2, y1:-1:y2),
            max(x1:x2, x1:-1:x2)
        ] .+= 1
    # Handle diagonal lines
    else
        # Get all x values to iterate over
        # Takes ascending or descending, whichever is valid
        xs = max(
            collect(x1:x2),
            collect(x1:-1:x2),
        )
        # Get all y values to iterate over
        ys = max(
            collect(y1:y2),
            collect(y1:-1:y2),
        )
        # Update diagram
        for (x, y) ∈ zip(xs, ys)
        # for i in 1:length(xs)
            # diagram[ys[i], xs[i]] += 1
            diagram[y, x] += 1
        end
    end
    # end
end

println('\n',sum(diagram .>= 2))

using Plots
pyplot()

fig = plot(
    heatmap(diagram, aspect_ratio=1),
    axis=nothing,
    border=:none,
    dpi=300
)
savefig(fig, "line_heatmap.png")