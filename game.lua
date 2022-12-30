-- Define the shop's inventory
inventory = {
    {"Star booster", 50, 100},
    {"Cash booster", 100, 200},
    {"+Money", 125, 0},
    {"Super booster", 250, 500},
}

-- Display the shop's inventory
function displayInventory()
    print("Welcome to the shop! Here is what we have for sale:")
    for i, item in ipairs(inventory) do
        print(i .. ". " .. item[1] .. ": " .. item[2] .. " stars or " .. item[3] .. " cash")
    end
end

-- Handle a purchase from the shop
function handlePurchase(choice)
    -- Check if the chosen item is in the inventory
    if choice > 0 and choice <= #inventory then
        -- Get the chosen item
        item = inventory[choice]
        -- Check if the player has enough stars or cash to make the purchase
        if stars >= item[2] then
            -- Deduct the stars from the player's total
            stars = stars - item[2]
            -- Add the item to the player's inventory
            table.insert(playerInventory, item[1])
            -- Print a message indicating the purchase was successful
            print("Purchase successful! You have " .. stars .. " stars and " .. cash .. " cash.")
        elseif cash >= item[3] then
            -- Deduct the cash from the player's total
            cash = cash - item[3]
            -- Add the item to the player's inventory
            table.insert(playerInventory, item[1])
            -- Print a message indicating the purchase was successful
            print("Purchase successful! You have " .. stars .. " stars and " .. cash .. " cash.")
        else
            -- Print a message indicating the purchase was not successful
            print("Sorry, you do not have enough stars or cash to make this purchase.")
        end
    else
        -- Print a message indicating the chosen item is invalid
        print("Invalid item. Please try again.")
    end
end

-- Count stars
function countStars()
    -- Generate a random number of star emojis (between 1 and 25)
    numEmojis = math.random(1, 25)
    -- Print the star emojis
    print(string.rep("⭐", numEmojis))
    -- Ask the player to enter the number of star emojis
    print("Enter the number of star emojis:")
    numStars = tonumber(io.read())
    -- Check if the player counted the correct number
    if numStars == numEmojis then
        -- Add the stars to the player's total
        stars = stars + numStars
        -- Check if the player has the "+Money" item in their inventory
        if contains (playerInventory, "+Money") then
            -- Add the same number of cash as the number of stars
            cash = cash + numStars
        end
        print("Correct! You have " .. stars .. " stars and " .. cash .. " cash.")
    else
        print("Incorrect. You have " .. stars .. " stars and " .. cash .. " cash.")
    end
end

-- Check if a table contains a given value
function contains(table, value)
    for _, v in ipairs(table) do
        if v == value then
            return true
        end
    end
    return false
end

-- Load the saved data
function loadData()
    -- Open the data file in read mode
    local file = io.open("stat_save.gsnarf", "r")
    -- Check if the file exists
    if file then
        -- Read the data from the file
        stars = tonumber(file:read())
        cash = tonumber(file:read())
        -- Read the player's inventory from the file
        local line = file:read()
        while line do
            -- Add the item to the player's inventory
            table.insert(playerInventory, line)
            -- Read the next line from the file
            line = file:read()
        end
        -- Close the file
        file:close()
    else
        -- Set the default data if the file does not exist
        stars = 0
        cash = 0
        playerInventory = {}
    end
end

-- Save the data
function saveData()
    -- Open the data file in write mode
    local file = io.open("stat_save.gsnarf", "w")
    -- Write the data to the file
    file:write(stars .. "\n")
    file:write(cash .. "\n")
    -- Write the player's inventory to the file
    for _, item in ipairs(playerInventory) do
        file:write(item .. "\n")
    end
    -- Close the file
    file:close()
end

-- Initialize the player's inventory
playerInventory = {}

function saveInventory()
    -- Open the inventory_save file in write mode
    local file = io.open("inventory_save.gsnarf", "w")
    -- Write the player's inventory to the file
    for _, item in ipairs(playerInventory) do
        file:write(item .. "\n")
    end
    -- Close the file
    file:close()
end

function loadInventory()
    -- Open the inventory_save file in read mode
    local file = io.open("inventory_save.gsnarf", "r")
    -- Check if the file exists
    if file then
        -- Read the player's inventory from the file
        local line = file:read()
        while line do
            -- Add the item to the player's inventory
            table.insert(playerInventory, line)
            -- Read the next line from the file
            line = file:read()
        end
        -- Close the file
        file:close()
    else
        -- Set the default inventory if the file does not exist
        playerInventory = {}
    end
end

-- Load the saved data
loadData()
loadInventory()

-- Print a greeting message
print("Welcome to the star counting game! You have " .. stars .. " stars and " .. cash .. " cash.")

-- Main game loop
while true do
    -- Display the main menu
    print("What would you like to do?")
    print("1. Count stars")
    print("2. Visit the shop")
    print("3. Check inventory")
    print("4. Quit game (Only way to save!)")
    -- Get the player's choice
    print("Enter your choice:")
    choice = tonumber(io.read())
    -- Handle the player's choice
    if choice == 1 then
        countStars()
    elseif choice == 2 then
        displayInventory()
        print("Enter the number of the item you would like to purchase:")
        item = tonumber(io.read())
        handlePurchase(item)
    elseif choice == 3 then
        print("You have the following items in your inventory:")
        for _, item in ipairs(playerInventory) do
            print(item)
        end
        print("You have " .. stars .. " stars and " .. cash .. " cash.")
    elseif choice == 4 then
        -- Save the data before quitting
        saveData()
        saveInventory()
        -- Print a goodbye message
        print("Thank you for playing! Goodbye.")
        -- Break out of the game loop
        break
    else
        -- Print an error message
        print("Invalid choice. Please try again.")
    end
end



