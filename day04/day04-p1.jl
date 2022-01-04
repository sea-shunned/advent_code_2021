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

function play_bingo(called_numbers, boards, masks, board_size)
    # Loop over each of the called numbers
    for num in called_numbers
        # Update the masks
        masks += (boards .== num)
        # Check if a winner has been found
        # First check column sums
        for (idx, sums) in enumerate(eachslice(sum(masks, dims=1), dims=3))
            if board_size in sums
                return calc_score(boards, masks, num, idx)
            end
        end
        # Then row sums
        for (idx, sums) in enumerate(eachslice(sum(masks, dims=2), dims=3))
            if board_size in sums
                return calc_score(boards, masks, num, idx)
            end
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

score = play_bingo(called_numbers, boards, masks, board_size)
println(score)