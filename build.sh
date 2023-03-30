# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/CherishOS/android_manifest -b tiramisu -g default,-mips,-darwin,-notdefault
git clone https://github.com/Maxx12211/Local_manifest.git --depth 1 -b cherish-blu .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j16
git clone --depth=1 https://github.com/Maxx12211/android_device_xiaomi_rova.git -b 13-cherish device/xiaomi/rova
git clone --depth=1 https://github.com/Maxx12211/android_vendor_xiaomi_rova.git -b 13 vendor/xiaomi/rova
git clone --depth=1 https://github.com/Maxx12211/android_kernel_xiaomi_rova.git -b 13.0 kernel/xiaomi/rova

# build rom
curl -Lo barom.sh https://raw.githubusercontent.com/alanndz/barom/main/barom.sh
chmod +x barom.sh
./barom.sh -t ${TG_CHAT_ID} ${TG_TOKEN}
./barom.sh --ccache-dir "${WORKDIR}/ccache" --ccache-size 20G
./barom.sh --device rova --lunch cherish_rova-userdebug
./barom.sh -b -j 8 -u wet --timer 95m -- mka bacon

# end
