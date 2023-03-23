# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/BlissRoms/platform_manifest.git -b typhoon -g default,-mips,-darwin,-notdefault
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)
git clone --depth=1 https://github.com/Maxx12211/android_device_xiaomi_rova.git -b 13-bliss device/xiaomi/rova
git clone --depth=1 https://github.com/Maxx12211/android_vendor_xiaomi_rova.git -b 13 vendor/xiaomi/rova
git clone --depth=1 https://github.com/Maxx12211/android_kernel_xiaomi_rova.git -b 13.0 kernel/xiaomi/rova

# build rom
source $CIRRUS_WORKING_DIR/script/config
timeStart

. build/envsetup.sh
lunch bliss_rova-user
mkfifo reading
tee "${BUILDLOG}" < reading &
build_message "Building Started"
progress &
blissify rova -j8  > reading & sleep 95m

retVal=$?
timeEnd
statusBuild
# end
