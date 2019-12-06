# Cookieater [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) [![Actions Status](https://github.com/goriok/cookieater/workflows/ci/badge.svg)](https://github.com/goriok/cookieater/actions) ![Docker Automated build](https://img.shields.io/docker/cloud/automated/goriok/cookieater)
For now it's very simple, I just want to store my cookies in a store (redis for now) and use Elixir as simple as possible....

Probably it will have more functionalities in a close future....
```
                .---. .---.
               :   o : o   :    me want cookie!
           _..-:     :     :-.._    /
       .-''  '  `---' `---' "   ``-.
     .'   "   '  "  .    "  . '  "  `.
    :   '.---.,,.,...,.,.,.,..---.  ' ;
    `. " `.                     .' " .'
     `.  '`.                   .' ' .'
      `.    `-._           _.-' "  .'  .----.
        `. "    '"--...--"'  . ' .'  .'  o   `.
        .'`-._'    " .     " _.-'`. :       o  :
     .'      ```--.....--'''    ' `:_:  o      :
    .'    "     '         "     "   ; `.;";";";'
   ;         '       "       '     . ; .' ; ; ;
  ;     '         '       '   "    .'      .-'
  '  "     "   '      "           "    _.-'
```

## TL;DR;

### using
redis sentinels:
``` 
docker run -e REDIS_SENTINELS=<hosts> -e REDIS_SENTINELS_GROUP=<group> -p 4000:4000 goriok/cookieater:latest    
```
---
### developing

store dependency:
```
docker run -d -p 6379:6379 redis:alpine
```
testing: 
``` 
mix test
```   
running:
```
mix run --no-halt
```
