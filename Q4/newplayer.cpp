void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
    Player* player = nullptr;
    bool newPlayer = (player = g_game.getPlayerByName(recipient)) == nullptr;

    if (newPlayer) {
        player = new Player(nullptr);
        if (!IOLoginData::loadPlayerByName(player, recipient)) {
            delete player;
            return;
        }
    }

    Item* item = Item::CreateItem(itemId);
    if (!item) {
        if (newPlayer) {
            delete player;
        }
        return;
    }

    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    if (player->isOffline()) {
        IOLoginData::savePlayer(player);
        delete player;
    }
    // I am guessing database object management will handle the deletion of player object
    // So need to delete player if it's online as loadPlayerByName() stores it in database with properly set up properties
    // Otherwise, will need to delete player object

    if (newPlayer) {
		delete player;
	}
}
