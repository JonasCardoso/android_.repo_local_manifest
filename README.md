Manifest for Android R / LineageOS 18.1
====================================
Project Mi5|Gemini

---

Manual Way:

To initialize LineageOS 18.1 Repo:

    repo init -u git://github.com/LineageOS/android.git -b lineage-18.1

---

To initialize Manifest for all devices:

    curl --create-dirs -L -o .repo/local_manifests/xiaomi_msm8996_default.xml -O -L https://raw.github.com/JonasCardoso/android_.repo_local_manifest/lineage-18.1/xiaomi_msm8996_default.xml

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