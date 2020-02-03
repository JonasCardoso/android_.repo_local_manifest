Manifest for Android Ten / Pixel Experience
====================================
Project Mi5|Gemini / Project Mi5S|Capricorn / Project Mi5s Plus|Natrium / Project Mi Mix|Lithium / Project Mi Note 2|Scorpio - 3.18.x

---

Manual Way:

To initialize Pixel Experience Repo:

    repo init -u https://github.com/PixelExperience/manifest -b ten

---

To initialize Manifest for all devices:

    curl --create-dirs -L -o .repo/local_manifests/xiaomi_msm8996_default.xml -O -L https://raw.github.com/PixelExperience-Xiaomi-MSM8996/android_.repo_local_manifest/ten-3.18.x/xiaomi_msm8996_default.xml

---

Sync the repo:

    repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

---

Initialize the environment:

    . build/envsetup.sh

---

To build ROM for Xiaomi Mi5:

    lunch aosp_gemini-userdebug

    mka bacon -j$(nproc --all)

---

To build ROM for Xiaomi Mi5S:

    lunch aosp_capricorn-userdebug

    mka bacon -j$(nproc --all)
---

To build ROM for Xiaomi Mi5s Plus:

    lunch aosp_natrium-userdebug

    mka bacon -j$(nproc --all)

---

To build ROM for Xiaomi Mi Mix:

    lunch aosp_lithium-userdebug

    mka bacon -j$(nproc --all)
    
---

To build ROM for Xiaomi Mi Note 2:

    lunch aosp_scorpio-userdebug

    mka bacon -j$(nproc --all)
