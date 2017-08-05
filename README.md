RedSocks for OpenWrt
===

简介
---

 本项目是 [RedSocks][1] 在 OpenWrt 上的移植  
 当前版本: 0.5
 [预编译 IPK 下载][2]  

编译
---

 - 从 OpenWrt 的 [SDK][S] 编译  

   ```bash
   # 以 ar71xx 平台为例
   tar xjf OpenWrt-SDK-ar71xx-for-linux-x86_64-gcc-4.8-linaro_uClibc-0.9.33.2.tar.bz2
   cd OpenWrt-SDK-ar71xx-*
   # 获取 Makefile
   git clone https://github.com/tominescu/redsocks-openwrt.git package/redsocks-dev
   # 选择要编译的包 Network -> redsocks-dev
   make menuconfig
   # 开始编译
   make package/redsocks-dev/compile V=99
   ```


  [1]: https://github.com/darkk/redsocks
  [2]: https://github.com/tominescu/redsocks-openwrt/releases
