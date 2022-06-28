# nsmb2-levels
## Setup
Game version being used is New Super Mario Bros. 2 (USA) (Gold Edition) [0004000000137E00].

* From the unmodified game, copy the extracted romfs and exefs into `$repo_root/rom_orig/` and a decrypted ROM for Citra to `$repo_root/rom_orig.cxi`, 
* Build code using Magikoopa by following [this](https://nsmbhd.net/thread/4629-magikoopa-tutorial-how-asm-hacks-are-setup/)
* From the Magikoopa folder, copy `code.bin` to `$repo_root/rom/exefs/code.bin` and `exheader.bin` to `$repo_root/rom/exheader.bin`
* Point Coinkiller towards rom/romfs
* Create the following symlinks:
```
$repo_root/rom/exefs/ to $CITRA_USER_DIR/load/mods/0004000000137E00/exefs/  
$repo_root/rom/exheader.bin to $CITRA_USER_DIR/load/mods/0004000000137E00/exheader.bin  
$repo_root/rom/romfs/ to $CITRA_USER_DIR/sdmc/nsmb2/
```
* Edit levels in CoinKiller and play them using in Citra
