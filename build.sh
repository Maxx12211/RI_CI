# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Maxx12211/android_manifest -b tiramisu3 -g default,-mips,-darwin,-notdefault
git clone https://github.com/maxx0021/local_manifests-rdp -b a13 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j16

# build rom
curl -Lo barom.sh https://raw.githubusercontent.com/alanndz/barom/main/barom.sh
chmod +x barom.sh
./barom.sh -t ${TG_CHAT_ID} ${TG_TOKEN}
./barom.sh --ccache-dir "${WORKDIR}/ccache" --ccache-size 20G
./barom.sh --device Mi8937 --lunch cherish_Mi8937-userdebug
./barom.sh -b -j 8 -u gof --timer 95m -- mka bacon

# end
