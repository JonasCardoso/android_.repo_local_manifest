Manifest for Android Pie / Pixel Experience
====================================
Project Mi5|Gemini / Project Mi5S|Capricorn

---

Manual Way:

To initialize Pixel Experience Repo:

    repo init -u https://github.com/PixelExperience/manifest -b pie

---

To initialize Manifest for all devices:

    curl --create-dirs -L -o .repo/local_manifests/xiaomi_msm8996_default.xml -O -L https://raw.github.com/JonasCardoso/android_.repo_local_manifest/pe-pie/xiaomi_msm8996_default.xml

---

Sync the repo:

    repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

---

Initialize the environment:

    . build/envsetup.sh

---

To build ROM for Xiaomi Mi5:

    lunch aosp_gemini-userdebug

    mka bacon -jX

---

To build ROM for Xiaomi Mi5S:

    lunch aosp_capricorn-userdebug

    mka bacon -jX
