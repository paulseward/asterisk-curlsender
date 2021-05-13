# Curlsender
Stupidly simplistic call generator for my collection of ancient telephone exchanges.
Does little to no checking, it just throws calls at asterisk and hopes they succeed.

Needs an asterisk server to run against, with ari enabled, and a bit of customisation
to make it work for your environment.

## Setup
### Asterisk

`modules.conf`:
```
load   => res_ari.so
load   => res_ari_channels.so
```

`ari.conf`
```
[general]
enabled = yes
pretty = yes
allowed_origins = localhost:8088

[asterisk]             # ARI_USER
type = user
read_only = no
password = asterisk    # ARI_PASS
```

Sample callsender target definition. This picks a random call duration timeout and then forwards the call to your core dialplan (eg `Local-Core` in my case)

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

### `curlsender.sh`

* Change `ARI_USER` and `ARI_PASS` to match the values you picked in your `ari.conf`
* Change the `CALL_GROUP` numbers to be a list of valid numbers you want to dial
* Change any of the other parameters you want

## Use
Just run `./curlsender.sh` with no parameters to make a run
