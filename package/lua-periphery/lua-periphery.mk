################################################################################
#
# lua-periphery
#
################################################################################

LUA_PERIPHERY_VERSION_UPSTREAM = 1.0.4
LUA_PERIPHERY_VERSION = $(LUA_PERIPHERY_VERSION_UPSTREAM)-1
LUA_PERIPHERY_SUBDIR = lua-periphery
LUA_PERIPHERY_DEPENDENCIES = c-periphery
LUA_PERIPHERY_LICENSE = MIT
LUA_PERIPHERY_LICENSE_FILES = $(LUA_PERIPHERY_SUBDIR)/LICENSE

$(eval $(luarocks-package))
