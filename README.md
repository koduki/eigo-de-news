英語de読もう！
====================

This is support system for reading English.

How to use
---------------------

### 1. execute crawler

```bash

# for windows
PS$ docker run --rm -v /c/Users/koduki/git/koduki/eigo-de-news:/app koduki/eigodenews ruby src/main.rb
```

### 2. run application server

```bash
# check IP address.
PS$ docker-machine ip default
192.168.xxx.xxx

# run
PS$ docker-compose up
```

### 3. access by browser

```
http://192.168.xxx.xxx:4567/index.html
```
