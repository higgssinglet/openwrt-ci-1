#!/bin/bash
cd /home/runner/openwrt

echo 'Update luci-app-passwall & openwrt-chinadns-ng'
rm -rf /home/runner/openwrt/package/lienol/luci-app-passwall/
rm -rf /home/runner/openwrt/package/ctcgfw/openwrt-chinadns-ng/
cp -R /home/runner/openwrt-package/lienol/luci-app-passwall/ /home/runner/openwrt/package/lienol/
cp -R /home/runner/openwrt-package/package/chinadns-ng/ /home/runner/openwrt/package/lienol/

echo 'Update luci-theme-argon'
rm -rf /home/runner/openwrt/package/lean/luci-theme-argon/
cp -R /home/runner/luci-theme-argon/ /home/runner/openwrt/package/lean/

echo 'Add luci-app-vssr'
rm -rf /home/runner/openwrt/package/ctcgfw/luci-app-vssr/
cp -R /home/runner/luci-app-vssr/ /home/runner/openwrt/package/lean/

echo 'Fix serverchan temperature bug'
sed -i "s?/sys/class/thermal/thermal_zone\*/temp?/sys/class/hwmon/hwmon0/temp1_input?g" /home/runner/openwrt/package/ctcgfw/luci-app-serverchan/root/usr/bin/serverchan/serverchan

echo 'Modify default theme'
sed -i "s/luci-theme-bootstrap/luci-theme-argon/g" /home/runner/openwrt/feeds/luci/collections/luci/Makefile

echo 'Fix koolproxyR bug'
sed -i "s/\$(ARCH),arm/\$(ARCH),aarch64/g" /home/runner/openwrt/package/ctcgfw/luci-app-koolproxyR/Makefile

echo 'Install po2lmo'
rm -rf /home/runner/openwrt/package/ctcgfw/luci-app-openclash
git clone https://github.com/vernesong/OpenClash.git /home/runner/openwrt/package/ctcgfw/luci-app-openclash/
pushd /home/runner/openwrt/package/ctcgfw/luci-app-openclash/luci-app-openclash/tools/po2lmo
make && sudo make install
popd
