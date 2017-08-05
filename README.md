# armagetron-stats

This is a simple status page for a dedicated Armagetron Advanced server.

## Requirements

* A D2 compiler
* dub
* libevent (vibe.d depends on it)

## Installation

Build the binary:

```
dub build
```

Place the configuration file in `/usr/local/etc/armagetron-stats.sdl` and edit
it to match your needs:

```
cp ./armagetron-stats.defaults.sdl /usr/local/etc/armagetron-stats.sdl
vim /usr/local/etc/armagetron-stats.sdl
```

Run the app

```
./armagetron-stats
```
