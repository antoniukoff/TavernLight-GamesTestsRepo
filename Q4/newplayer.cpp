void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
    Player* player = nullptr;
    bool newPlayer = (player = g_game.getPlayerByName(recipient)) == nullptr; // bool checking if the player was not found

    if (newPlayer) { // if true will allocate a new one
        player = new Player(nullptr);
        if (!IOLoginData::loadPlayerByName(player, recipient)) {
            delete player; // delete newly allocated player if condition was false
            return;
        }
    }

    Item* item = Item::CreateItem(itemId);
    if (!item) {
        if (newPlayer) {
            delete player; // if item was not created and delete the allocated player
        }
        return;
    }

    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    if (player->isOffline()) {
        IOLoginData::savePlayer(player);
        delete player; // if offline free the resources of the player even if was valid on line 4
    }
    // I am guessing database object management will handle the deletion of player object
    // So need to delete player if it's online as loadPlayerByName() stores it in database with properly set up properties
    // Otherwise, will need to delete player object

    if (newPlayer) {
		delete player;
	}
}
