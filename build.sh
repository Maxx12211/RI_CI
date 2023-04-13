# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Maxx12211/android_manifest -b tiramisu3 -g default,-mips,-darwin,-notdefault
git clone https://github.com/maxx0021/local_manifests-rdp -b a13 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j16

# build rom
source $CIRRUS_WORKING_DIR/script/config
timeStart

. build/envsetup.sh
lunch cherish_Mi8937-userdebug
mkfifo reading
tee "${BUILDLOG}" < reading &
build_message "Building Started"
progress &
mka bacon -j8  > reading & sleep 95m

retVal=$?
timeEnd
statusBuild
# end
