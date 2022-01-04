data = split.(readlines("input.txt"), "")
data = parse.(Int, hcat(data...))

binary_to_int(x) = parse(Int, "0b"*join(Int.(x)))


function calc_rating(data, rating::String)
    # Set whether we want most or least common
    if rating == "o2"
        compare_func = argmax
        ties = 1
    elseif rating == "co2"
        compare_func = argmin
        ties = 0
    end
    data_mod = deepcopy(data)
    # Get shape of input
    bit_length, total_inputs = size(data)
    # Loop over each bit
    for col in 1:bit_length

        # println(col, " ", size(data_mod)[2])
        value_counts = [count(==(i), data_mod[col, :]) for i in [0,1]]
        # println(value_counts)
        # Handle ties
        if minimum(value_counts) == maximum(value_counts)
            keep_value = ties
        # Determine whether we keep 0s or 1s
        else
            keep_value = (
                compare_func(value_counts)
            )-1
        end
        # Filter values
        data_mod = data_mod[:, data_mod[col, :] .== keep_value]
        # End early if only 1 value left
        # println(data_mod)
        if size(data_mod)[2] == 1
            return binary_to_int(data_mod[:, 1])
        end
    end
    return binary_to_int(data_mod[:, 1])
end

o2 = calc_rating(data, "o2")
co2 = calc_rating(data, "co2")

println(o2, " ", co2, " ", o2*co2)