resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

ui_page 'assets/index.html'

client_scripts {
    'client/main.lua',
    'client/events.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/main.lua'
}

files {
    'assets/index.html',
    'assets/css/style.css',
    'assets/img/faktura.jpg',
    'assets/js/jquery.js',
    'assets/js/main.js',
}

exports {
    "SendBilling",
    "FetchBillings",
    "SentBillings"
}

