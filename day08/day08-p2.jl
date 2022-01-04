
input = readlines("input.txt")

function determine_digits(input)
    # Container for result
    total_outputs = 0
    # Loop over inputs
    for line in input
        # Container for digits
        digit_mapper = Dict()
        # Extract the digits
        input_digits, output_digits = split(line, " | ")
        # Extract digits and convert to Sets
        input_digits = Set.(split(input_digits, ' '))
        output_digits = Set.(split(output_digits, ' '))

        # Loop through inputs and determine lengths
        input_lengths = Int[]
        for digit in input_digits
            push!(input_lengths, length(digit))
        end

        # Get indices of unique digits
        idx_dig1 = findfirst(isequal(2), input_lengths)
        digit_mapper[1] = input_digits[idx_dig1]
        idx_dig7 = findfirst(isequal(3), input_lengths)
        digit_mapper[7] = input_digits[idx_dig7]
        idx_dig4 = findfirst(isequal(4), input_lengths)
        digit_mapper[4] = input_digits[idx_dig4]
        idx_dig8 = findfirst(isequal(7), input_lengths)
        digit_mapper[8] = input_digits[idx_dig8]
        # Now start deducing
        # Loop through all 6-length digits
        for i in findall(isequal(6), input_lengths)
            # Identify the digit that has digit 4 segments as a subset (digit 9)
            if issubset(digit_mapper[4], input_digits[i])
                digit_mapper[9] = input_digits[i]
            # The 6-length digit not containing everything in 1 must be digit 6
            elseif !issubset(digit_mapper[1], input_digits[i])
                digit_mapper[6] = input_digits[i]
            # The final one must be digit 0
            else
                digit_mapper[0] = input_digits[i]
            end
        end
        # Now go through the 5-lengths to find the digit 3
        for i in findall(isequal(5), input_lengths)
            # Only digit 3 contains digit 1
            if issubset(digit_mapper[1], input_digits[i])
                digit_mapper[3] = input_digits[i]
            # Only digit 5 contains 4 - 1 (segments b&d)
            elseif issubset(setdiff(digit_mapper[4], digit_mapper[1]), input_digits[i])
                digit_mapper[5] = input_digits[i]
            # Otherwise it must be digit 2
            else
                digit_mapper[2] = input_digits[i]
            end
        end
        # Map segments to digits
        segment_digit_mapper = Dict(
            (v, string(k)) for (k, v) in digit_mapper
        )
        digit_str = string()
        for output_segments in output_digits
            # Add decoded digit
            digit_str *= segment_digit_mapper[output_segments]
        end
        # Add digit to total sum
        total_outputs += parse(Int, digit_str)
    end
    # Return the sum of all the digits
    return total_outputs
end

function update_mapper(segment_mapper, remove_letters, update_keys)
    for k in update_keys
        segment_mapper[k] = setdiff(
            segment_mapper[k], remove_letters
        )
    end
    return segment_mapper
end

result = determine_digits(input)
println(result)