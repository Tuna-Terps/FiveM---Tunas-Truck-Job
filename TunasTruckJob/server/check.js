//const fs = require('fs')

console.log(`
::::::::::: :::::::::  :::    :::  ::::::::  :::    :::      ::::::::::: ::::::::  :::::::::       
    :+:     :+:    :+: :+:    :+: :+:    :+: :+:   :+:           :+:    :+:    :+: :+:    :+:      
    +:+     +:+    +:+ +:+    +:+ +:+        +:+  +:+            +:+    +:+    +:+ +:+    +:+      
    +#+     +#++:++#:  +#+    +:+ +#+        +#++:++             +#+    +#+    +:+ +#++:++#+       
    +#+     +#+    +#+ +#+    +#+ +#+        +#+  +#+            +#+    +#+    +#+ +#+    +#+      
    #+#     #+#    #+# #+#    #+# #+#    #+# #+#   #+#       #+# #+#    #+#    #+# #+#    #+#      
    ###     ###    ###  ########   ########  ###    ###       #####      ########  #########
^1--------------------------------------------------------------------------------------------------------
^5><> Created by ^2Tuna Terps ^5=> If you enjoy the script, go ahead and check out some of my other work <3 !
^1-------------------------------------------------------------------------------------------------------- 
^5https://github.com/Tuna-Terps
^5https://www.youtube.com/channel/UCqoEtIuzJc3PGk9YX6kslNw
^1--------------------------------------------------------------------------------------------------------
`)

(function(){
    // right
    fs.readFile(`../fxmanifest.lua`, { encoding: 'utf8' }, (err, data) => {
        setImmediate(() => { // the callback will be called next game tick
        console.log(data)
            emitNet('chat:addMessage', -1, {
                args: [ data ]
            });
        });
    });
    $.get()
})();