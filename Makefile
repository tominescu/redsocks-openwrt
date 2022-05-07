#
# Copyright (C) 2014-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=redsocks-dev
PKG_VERSION:=0.5-20161228
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_PROTO:=git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_URL:=https://github.com/darkk/redsocks.git
PKG_SOURCE_VERSION:=19b822e345f6a291f6cff6b168f1cfdfeeb2cd7d

PKG_MAINTAINER:=Johannes Morgenroth <jm@m-network.de>
PKG_LICENSE:=Apache-2.0

include $(INCLUDE_DIR)/package.mk

define Package/redsocks-dev
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+libevent2 +libevent2-core +libevent2-extra
  TITLE:=Redirect any TCP connection to a SOCKS or HTTPS proxy server
endef

define Package/redsocks-dev/conffiles
/etc/config/redsocks
endef

define Package/redsocks-dev/description
 Redsocks is a daemon running on the local system, that will transparently
 tunnel any TCP connection via a remote SOCKS4, SOCKS5 or HTTP proxy server. It
 uses the system firewall's redirection facility to intercept TCP connections,
 thus the redirection is system-wide, with fine-grained control, and does
 not depend on LD_PRELOAD libraries.
 
 Redsocks supports tunneling TCP connections and UDP packets. It has
 authentication support for both, SOCKS and HTTP proxies.
 
 Also included is a small DNS server returning answers with the "truncated" flag
 set for any UDP query, forcing the resolver to use TCP.
endef

define Package/redsocks-dev/install
	$(INSTALL_DIR) $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/redsocks $(1)/usr/sbin/
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) files/redsocks.init $(1)/etc/init.d/redsocks
	$(INSTALL_DATA) files/redsocks.conf.template $(1)/etc/
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/redsocks.config $(1)/etc/config/redsocks
	$(INSTALL_DIR) $(1)/etc/uci-defaults/
	$(INSTALL_DATA) files/redsocks.uci-default $(1)/etc/uci-defaults/97-redsocks
	$(INSTALL_DIR) $(1)//usr/share/redsocks/
	$(INSTALL_DATA) files/firewall.include $(1)/usr/share/redsocks/firewall.include

endef

$(eval $(call BuildPackage,redsocks-dev))
