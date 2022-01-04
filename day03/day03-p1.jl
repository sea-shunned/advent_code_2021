data = split.(readlines("input.txt"), "")
data = parse.(Int, hcat(data...))

binary_to_int(x) = parse(Int, "0b"*join(Int.(x)))

function calc_power(data)
    # Get shape of input
    bit_length, total_inputs = size(data)
    # Create containers
    γ = BitVector()
    # Loop over columns
    for col in 1:bit_length
        count_ones = sum(data[col, :])
        if count_ones > total_inputs/2
            push!(γ, 1)
        else
            push!(γ, 0)
        end
    end
    # Calc the inverse
    ϵ = .!γ
    return binary_to_int(γ) * binary_to_int(ϵ)
end

power = calc_power(data)
println(power)


# # Convert to decimal
# γ = Parse(Int, γ, base=2)



# println(γ * ϵ) 