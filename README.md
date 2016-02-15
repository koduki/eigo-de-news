英語de読もう！
====================

This is support system for reading English.

How to use
---------------------

### 1. execute crawler

```bash
# for Windows
PS$ docker-compose -f ./docker-compose-dev.yml run -d app ruby /src/main.rb

# for Linux
$ docker-compose -f ./docker-compose-prod.yml run app ruby /src/main.rb
```

### 2. run application server

```bash
# check IP address.
PS$ docker-machine ip default
192.168.xxx.xxx

# run on development
PS$ docker-compose -f ./docker-compose-dev.yml up app

# run on production
$ docker-compose -f ./docker-compose-prod.yml pull
$ docker-compose -f ./docker-compose-prod.yml up app

```

### 3. access by browser

```
http://192.168.xxx.xxx:4567/index.html
```

### 4. REPL

```[bash]
PS$ docker run -it --rm -v /c/Users/koduki/git/koduki/eigo-de-news:/app koduki/eigodenews irb
```
