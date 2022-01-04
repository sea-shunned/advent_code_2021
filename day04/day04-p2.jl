using Debugger
using DelimitedFiles

# Get the first line
called_numbers = parse.(Int, split(readlines("input.txt")[1], ","))
# Get all the boards
raw_boards = readdlm("input.txt", Int, skipstart=1)
# Number of elements on a board
board_size = size(raw_boards)[2]
# Calc number of boards
num_boards = size(raw_boards)[1] ÷ board_size
# Split up into boards
boards = zeros(Int, board_size, board_size, num_boards)
for i in 1:num_boards
    boards[:, :, i] = raw_boards[((i-1)*board_size)+1:i*board_size, :]
end
# Create matrix for storing called numbers across boards
masks = zeros(Bool, board_size, board_size, num_boards)

function play_bingo(called_numbers, boards, masks, board_size, max_boards)
    # Container for non-winners
    non_winners = ones(Int, max_boards)
    last_winner = nothing
    # Loop over each of the called numbers
    for num in called_numbers
        # Update the masks
        masks += (boards .== num)
        # Calc col and row sums
        col_sums = dropdims(sum(masks, dims=1), dims=1)'
        row_sums = dropdims(sum(masks, dims=2), dims=2)'
        # Check who has won and set to 0
        for sums in eachslice(col_sums, dims=2)
            non_winners[sums .>=board_size] .= 0
        end
        for sums in eachslice(row_sums, dims=2)
            non_winners[sums .>=board_size] .= 0
        end
        # When there is one left, store the idx
        if sum(non_winners) == 1
            last_winner = argmax(non_winners)
        # When that board has won, return
        elseif sum(non_winners) == 0
            return calc_score(boards, masks, num, last_winner)
        end
    end
end

function calc_score(boards, masks, final_number, winner_idx)
    # Extract winning board
    board = boards[:, :, winner_idx]
    # Get unmarked numbers
    board = board .* abs.(masks[:, :, winner_idx] .- 1)
    return sum(board) * final_number
end

score = play_bingo(called_numbers, boards, masks, board_size, num_boards)
println(score)