Manifest for Android R / LineageOS 18.0
====================================
Project Mi5|Gemini / Project Mi5S|Capricorn / Project Mi5S Plus|Natrium / Project Mi Mix|Lithium / Project Mi Note2|Scorpio

---

Manual Way:

To initialize LineageOS 18.0 Repo:

    repo init -u git://github.com/LineageOS/android.git -b lineage-18.0

---

To initialize Manifest for all devices:

    curl --create-dirs -L -o .repo/local_manifests/xiaomi_msm8996_default.xml -O -L https://raw.github.com/JonasCardoso/android_.repo_local_manifest/lineage-18.0/xiaomi_msm8996_default.xml

---

Sync the repo:

    repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

---

Initialize the environment:

    source build/envsetup.sh

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
