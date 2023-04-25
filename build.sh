# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/RisingTechOSS/android.git -b thirteen -g default,-mips,-darwin,-notdefault
repo sync
git clone --depth=1 https://github.com/Maxx12211/device_xiaomi_rova.git -b a13-risingos device/xiaomi/rova
git clone --depth=1 https://github.com/Maxx12211/vendor_xiaomi_rova.git -b a13 vendor/xiaomi/rova
git clone --depth=1 https://github.com/Maxx12211/android_kernel_xiaomi_msm8937.git -b a13/master kernel/xiaomi/msm8937

# build rom
mv hardware/lineage/compat/Android.bp hardware/lineage/compat/Android.bpp
source $CIRRUS_WORKING_DIR/script/config
timeStart

. build/envsetup.sh
lunch lineage_rova-userdebug
mkfifo reading
tee "${BUILDLOG}" < reading &
build_message "Building Started"
progress &
mka bacon -j8  > reading & sleep 60m

retVal=$?
timeEnd
statusBuild
# end
