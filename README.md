# Stock Exchange

A Luanti mod that adds a stock exchange, an in-game currency, a homedecor shop, and a skin shop to a Minetest/Luanti server.

## Features

- **Stock Exchange node**: Players can buy and sell resources at fluctuating market prices. Prices drift slowly back towards default values over time, creating a living economy.
- **In-game currency**: Four banknote denominations (1 €, 10 €, 100 €, 1000 €) as craftitems. Players accumulate a virtual account balance shown via HUD.
- **Order node**: Shows the current prices and trends for all tradeable goods, grouped by category (ores, food, dyes, stones, fuel, …).
- **Award node**: Displays a high-score board of the wealthiest players.
- **Homedecor shop**: Buy decorative items from the *homedecor* mod for in-game currency.
- **Skin shop**: Browse and purchase player skins using in-game currency.
- **Admin chat commands**: `money_add`, `money_set`, `money_get` — manage player accounts (requires `server` priv).

## Nodes

| Node | Description |
|------|-------------|
| `stock_exchange:stock` | The stock exchange terminal — buy and sell goods |
| `stock_exchange:order` | Price board showing current market prices |
| `stock_exchange:award` | Richest-players leader board |
| `stock_exchange:mirror_glass` | Decorative mirror used in the skin shop |

## Admin Chat Commands

| Command | Description |
|---------|-------------|
| `/money_add <player> <value>` | Add (or subtract) currency from a player's account |
| `/money_set <player> <value>` | Set a player's account to an exact value |
| `/money_get <player>` | Show a player's current account balance |

All commands require the `server` privilege.

## Dependencies

- `default` (required)
- `homedecor` (optional — needed for homedecor shop and mirror glass node)
- `farming` (optional — farming items appear in the stock exchange)
- `moreores` (optional — silver and mithril ingots appear in the stock exchange)
- `wool`, `dye` (optional — wool and dyes appear in the stock exchange)
- `tubelib_addons1` (optional — bio gas/fuel appear in the stock exchange)
- `building_blocks` (optional — marble appears in the stock exchange)
- `sfinv` or `unified_inventory` (optional — skin shop integration)

## Installation

1. Download or clone this repository into your Minetest/Luanti `mods/` folder.
2. Enable the mod in your world settings or `minetest.conf`:
   ```
   load_mod_stock_exchange = true
   ```

## License

Copyright (C) 2017-2026 Joachim Stolberg  
LGPLv2.1+ — see [LICENSE.txt](LICENSE.txt) for details.

Skins included in the `textures/` folder are the work of their respective authors as indicated by the filename (e.g. `Aurora_by_WD8Ubisoft.png`). They are distributed under their original licenses.
