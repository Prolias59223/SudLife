fx_version 'cerulean'
games { 'gta5' };

-- Information

Author "TreeSpace - VFrench V.2"
description "CoreJob - RageUI V.1"

lua54 "yes"

client_scripts {
"src/RMenu.lua",
"src/menu/RageUI.lua",
"src/menu/Menu.lua",
"src/menu/MenuController.lua",
"src/components/*.lua",
"src/menu/elements/*.lua",
"src/menu/items/*.lua",
"src/menu/panels/*.lua",
"src/menu/windows/*.lua",
}

--

client_scripts {
    "@es_extended/locale.lua",
    "**/client/*.lua",
    "**/farming/*.lua",
    --"**/locales/*.lua",
    "**/shared/*.lua"
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "@es_extended/locale.lua",
    "**/server/*.lua",
   -- "**/locales/*.lua",
    "**/shared/config.lua"
}

shared_scripts {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua',
    "**/shared/config.lua"
}