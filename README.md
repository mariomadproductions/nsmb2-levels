# nsmb2-levels

## Setup
* Build code using magikoopa by following [this](https://nsmbhd.net/thread/4629-magikoopa-tutorial-how-asm-hacks-are-setup/)
* Copy code.bin to to rom/exefs/code.bin and exheader.bin to rom/exheader.bin
* Point Coinkiller towards rom/romfs
* Create the following symlinks:
```
rom/exefs/ to $CITRA_USER_DIR/load/mods/0004000000137E00/exefs/  
rom/exheader.bin to $CITRA_USER_DIR/load/mods/0004000000137E00/exheader.bin  
rom/romfs/ to $CITRA_USER_DIR/sdmc/nsmb2/
```
* Edit levels in CoinKiller and play them using New Super Mario Bros. 2 (USA) (Gold Edition) [0004000000137E00] in Citra
