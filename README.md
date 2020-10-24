# sh Blocks

Utilities/helpers to develop shell scripts.

## Install

### Using Basher

```sh
basher install protetore/shblocks
```

### Git Submodule

```sh
git submodule add https://github.com/protetore/shblocks
```

To update *shblocks* to the latest version you can run:

```sh
git pull --recurse-submodules
```

You can commit the submodule to you repository by doing:

```sh
git add .gitmodules shblocks/
git commit -m "building blocks"
```

If you added *shblocks* to your repo wand want a clean checkout, you can tell git to also checkout submodules:

```sh
git clone --recursive your/project/url
```

### Manually Downloading

```sh
mkdir -p shblocks/ && wget https://github.com/protetore/shblocks/archive/master.tar.gz -O - | tar -xz --strip-components=1 -C shblocks/
```

## Usage

### Import Using Basher

```sh
import protetore/shblocks output/logger.sh

logger::title "My APP"
```

### Manual

If you cloned as a subproject or downloaded to your project:

```sh
source <PATH>/<TO>/shblocks/output/logger.sh

logger::title "My APP"
```
