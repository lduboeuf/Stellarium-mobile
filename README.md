# Stellarium-mobile

[![OpenStore](https://open-store.io/badges/en_US.png)](https://open-store.io/app/me.lduboeuf.stellarium)

[Stellarium](https://stellarium.org) on Mobile.

This is a Ubuntu Touch adaptation of Cheng Xinlun's Stellarium app for Android/Ios : https://github.com/chengxinlun/Stellarium-android ,

Re-used compressed assets from initial work: https://noctua-software.com/stellarium-mobile 1.29 version

## Build for Ubuntu Touch

`clickable -c ubuntu_touch/clickable.json`


## Translate
https://hosted.weblate.org/projects/stellarium-mobile/app/ for stellarium core translations

Sky cultures translation is not available there due to the one "pot" file limitation, see `po/stellarium-skycultures` and `mobileData/skycultures`


### Update translation

- Translations `.pot` files are updated with command `make translate_core` and `make translate_skyculture` ( project need to be build first with qmake)
- To merge `po` files in `qm` files use the script `translation_generator.sh`




## Copyrights:
    Original Stellarium dev team
    Noctua-Software
    Cheng Xinlun


