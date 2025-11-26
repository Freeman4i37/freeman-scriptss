local allowedUsers = setmetatable({}, {
    __index = function()
        return true
    end
})

return allowedUsers