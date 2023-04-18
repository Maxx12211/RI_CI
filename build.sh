# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/ProjectBlaze/manifest.git -b 13 -g default,-mips,-darwin,-notdefault
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j16
#curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
#sudo apt-get install git-lfs
#repo init --git-lfs
#rm -rf external/chromium-webview/prebuilt/*
#rm -rf .repo/projects/external/chromium-webview/prebuilt/*.git
#rm -rf .repo/project-objects/LineageOS/android_external_chromium-webview_prebuilt_*.git
#repo sync -j16
git clone --depth=1 https://github.com/Maxx12211/device_xiaomi_rova.git -b a13-blaze device/xiaomi/rova
git clone --depth=1 https://github.com/Maxx12211/vendor_xiaomi_rova.git -b a13 vendor/xiaomi/rova
git clone --depth=1 https://github.com/Maxx12211/kernel_xiaomi_rova.git -b a13 kernel/xiaomi/rova

# build rom
source $CIRRUS_WORKING_DIR/script/config
timeStart

. build/envsetup.sh
lunch blaze_rova-eng
mkfifo reading
tee "${BUILDLOG}" < reading &
build_message "Building Started"
progress &
mka bacon -j8  > reading & sleep 95m

retVal=$?
timeEnd
statusBuild
# end
