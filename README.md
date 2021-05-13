# Curlsender
Stupidly simplistic call generator for my collection of ancient telephone exchanges.
Does little to no checking, it just throws calls at asterisk and hopes they succeed

Needs an asterisk server to run against, with agi enabled:

`modules.conf`:
```
load   => res_ari.so
load   => res_ari_channels.so
```

`ari.conf` - change `[asterisk]` and the password in curlsender.sh to match what you've picked here.
```
[general]
enabled = yes
pretty = yes
allowed_origins = localhost:8088

[asterisk]
type = user
read_only = no
password = asterisk
```

Sample callsender target definitions, that pick a random call duration timeout
and then forward to your core dialplan (eg `Local-Core` in my case)

`extensions.conf`:
```
;======================================================================
; Routiner
[Routiner]
;======================================================================
exten => _X.,1,Log(NOTICE, Routiner inward access with random timeout, dialing ${EXTEN})
exten => _X.,n,Set(TIMEOUT(absolute)=${RAND(10,15)})
exten => _X.,n,Goto(Local-Core,${EXTEN},1)
```
