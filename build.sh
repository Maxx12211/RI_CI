# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/alphadroid-project/manifest -b alpha-13 --git-lfs -g default,-mips,-darwin,-notdefault
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j16
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
sudo apt-get install git-lfs
repo init --git-lfs
rm -rf external/chromium-webview/prebuilt/*
rm -rf .repo/projects/external/chromium-webview/prebuilt/*.git
rm -rf .repo/project-objects/LineageOS/android_external_chromium-webview_prebuilt_*.git
repo sync -j16
git clone --depth=1 https://github.com/Maxx12211/android_device_xiaomi_rova.git -b 13.0-alphadroid device/xiaomi/rova
git clone --depth=1 https://github.com/Maxx12211/android_vendor_xiaomi_rova.git -b 13.0 vendor/xiaomi/rova
git clone --depth=1 https://github.com/Maxx12211/android_kernel_xiaomi_rova.git -b 13.0 kernel/xiaomi/rova

# build rom
source $CIRRUS_WORKING_DIR/script/config
timeStart

. build/envsetup.sh
lunch lineage_rova-userdebug
mkfifo reading
tee "${BUILDLOG}" < reading &
build_message "Building Started"
progress &
mka bacon -j8  > reading & sleep 95m

retVal=$?
timeEnd
statusBuild
# end
