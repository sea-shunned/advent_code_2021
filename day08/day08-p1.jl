input = readlines("input.txt")

function count_easy_digits(input)
    counts_1478 = 0

    for line in input
        outputs = split(split(line, " | ")[2], ' ')

        for pattern in outputs
            if length(pattern) in [2, 3, 4, 7]
                counts_1478 += 1
            end
        end
    end
    return counts_1478
end

println(count_easy_digits(input))