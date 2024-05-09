
function printSmallGuildNames(memberCount)
    -- this method is supposed to print names of all guilds that have less than memberCount max members
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
    local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount))
    if not resultId then -- simple check to confirm resultID is a valid pointer
		return 
	end

    -- loop printing out guild names until resultId.next points to nothing
    repeat
        local guildName = result.getString(resultId, "name") -- getString take in DBResult_ptr as a first parameter which is provided by the return value from the db.storeQuery
        print(guildName)
	until not result.next(resultId)

    result.free(resultId) -- frees the resources after completion
end