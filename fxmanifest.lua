fx_version 'adamant'
games { 'gta5' }

author 'Query Dev'
description 'Query Statushud'
version '1.0.0'

ui_page "interface/index.html"

client_script {
    'config.lua',
    'core/client.lua'
}

server_script {
    'core/server.lua'

}

files {
    'interface/img/**',
    'interface/sound/**',
    'interface/**'
}

shared_script { '@pma-voice/shared.lua' }