Manifest for Android Nougat / LineageOS 14.1
====================================
Project Mi5|Gemini / Project Mi5S|Capricorn / Project Mi5S Plus|Natrium / Project Mi Mix|Lithium / Project Mi Note2|Scorpio

---

Automatic Way:

script to download manifests, sync repo and build:

    curl --create-dirs -L -o build.sh -O -L https://raw.github.com/JonasCardoso/android_.repo_local_manifest/cm-14.1/build.sh

To use:

    source build.sh

---

Manual Way:

To initialize LineageOS 14.1 Repo:

    repo init -u git://github.com/LineageOS/android.git -b cm-14.1

---

To initialize Manifest for all devices:

    curl --create-dirs -L -o .repo/local_manifests/xiaomi_msm8996_default.xml -O -L https://raw.github.com/JonasCardoso/android_.repo_local_manifest/cm-14.1/xiaomi_msm8996_default.xml

---

Sync the repo:

    repo sync -c -jx --force-sync --no-clone-bundle --no-tags

---

Initialize the environment:

    source build/envsetup.sh

---

If Jack run out of memory:

    export ANDROID_JACK_VM_ARGS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4G"

---

To build ROM or TWRP for Xiaomi Mi5:

    brunch gemini

    breakfast gemini
    make recoveryimage

---

To build ROM or TWRP for Xiaomi Mi5S:

    brunch capricorn

    breakfast capricorn
    make recoveryimage

---

To build ROM or TWRP for Xiaomi Mi5S Plus:

    brunch natrium

    breakfast natrium
    make recoveryimage

---

To build ROM or TWRP for Xiaomi Mi Mix:

    brunch lithium

    breakfast lithium
    make recoveryimage

---

To build ROM or TWRP for Xiaomi Mi Note 2:

    brunch scorpio

    breakfast scorpio
    make recoveryimage
