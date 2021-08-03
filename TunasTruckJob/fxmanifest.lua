fx_version 'cerulean'
resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'
games { 'rdr3', 'gta5' }

author 'Tuna Terps'
description 'Simple ESX Trucking Job - Compatible with TunasPowerJob'
version '1.0.2'

client_scripts {
    'client/utils.lua',
    'client/job.lua'
}

server_script "server/payment.lua"
