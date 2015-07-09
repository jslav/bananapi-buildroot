################################################################################
#
# sunxi-ffmpeg
#
################################################################################

SUNXI_FFMPEG_VERSION = 1.2.1
SUNXI_FFMPEG_SOURCE = ffmpeg-$(SUNXI_FFMPEG_VERSION).tar.bz2
SUNXI_FFMPEG_SITE = http://ffmpeg.org/releases
SUNXI_FFMPEG_INSTALL_STAGING = YES

SUNXI_FFMPEG_CONF_OPTS = --extra-cxxflags="-march=native -O2 -pipe -pic" \
	--disable-asm \
	--prefix=/usr \
	--enable-avfilter \
	--disable-version3 \
	--enable-logging \
	--enable-optimizations \
	--disable-extra-warnings \
	--enable-avdevice \
	--enable-avcodec \
	--enable-avformat \
	--disable-x11grab \
	--enable-network \
	--disable-gray \
	--enable-swscale-alpha \
	--disable-small \
	--enable-dct \
	--enable-fft \
	--enable-mdct \
	--enable-rdft \
	--disable-crystalhd \
	--disable-vdpau \
	--disable-dxva2 \
	--enable-runtime-cpudetect \
	--disable-hardcoded-tables \
	--disable-memalign-hack \
	--enable-hwaccels \
	--disable-avisynth \
	--disable-frei0r \
	--disable-libopencore-amrnb \
	--disable-libopencore-amrwb \
	--disable-libopencv \
	--disable-libdc1394 \
	--disable-libfaac \
	--disable-libgsm \
	--disable-libmp3lame \
	--disable-libnut \
	--disable-libopenjpeg \
	--disable-librtmp \
	--disable-libschroedinger \
	--disable-libspeex \
	--disable-libtheora \
	--disable-libvo-aacenc \
	--disable-libvo-amrwbenc \
	--disable-symver \
	--disable-doc

SUNXI_FFMPEG_DEPENDENCIES += $(if $(BR2_PACKAGE_LIBICONV),libiconv) host-pkgconf

ifeq ($(BR2_PACKAGE_SUNXI_FFMPEG_GPL),y)
SUNXI_FFMPEG_CONF_OPTS += --enable-gpl
else
SUNXI_FFMPEG_CONF_OPTS += --disable-gpl
endif

ifeq ($(BR2_PACKAGE_SUNXI_FFMPEG_NONFREE),y)
SUNXI_FFMPEG_CONF_OPTS += --enable-nonfree
else
SUNXI_FFMPEG_CONF_OPTS += --disable-nonfree
endif

ifeq ($(BR2_PACKAGE_SUNXI_FFMPEG_FFMPEG),y)
SUNXI_FFMPEG_CONF_OPTS += --enable-ffmpeg
else
SUNXI_FFMPEG_CONF_OPTS += --disable-ffmpeg
endif

ifeq ($(BR2_PACKAGE_SUNXI_FFMPEG_FFPLAY),y)
SUNXI_FFMPEG_DEPENDENCIES += sdl
SUNXI_FFMPEG_CONF_OPTS += --enable-ffplay
SUNXI_FFMPEG_CONF_ENV += SDL_CONFIG=$(STAGING_DIR)/usr/bin/sdl-config
else
SUNXI_FFMPEG_CONF_OPTS += --disable-ffplay
endif

ifeq ($(BR2_PACKAGE_SUNXI_FFMPEG_FFSERVER),y)
SUNXI_FFMPEG_CONF_OPTS += --enable-ffserver
else
SUNXI_FFMPEG_CONF_OPTS += --disable-ffserver
endif

ifeq ($(BR2_PACKAGE_SUNXI_FFMPEG_AVRESAMPLE),y)
SUNXI_FFMPEG_CONF_OPTS += --enable-avresample
else
SUNXI_FFMPEG_CONF_OPTS += --disable-avresample
endif

ifeq ($(BR2_PACKAGE_SUNXI_FFMPEG_FFPROBE),y)
SUNXI_FFMPEG_CONF_OPTS += --enable-ffprobe
else
SUNXI_FFMPEG_CONF_OPTS += --disable-ffprobe
endif

ifeq ($(BR2_PACKAGE_SUNXI_FFMPEG_POSTPROC),y)
SUNXI_FFMPEG_CONF_OPTS += --enable-postproc
else
SUNXI_FFMPEG_CONF_OPTS += --disable-postproc
endif

ifeq ($(BR2_PACKAGE_SUNXI_FFMPEG_SWSCALE),y)
SUNXI_FFMPEG_CONF_OPTS += --enable-swscale
else
SUNXI_FFMPEG_CONF_OPTS += --disable-swscale
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_SUNXI_FFMPEG_ENCODERS)),all)
SUNXI_FFMPEG_CONF_OPTS += --disable-encoders \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_SUNXI_FFMPEG_ENCODERS)),--enable-encoder=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_SUNXI_FFMPEG_DECODERS)),all)
SUNXI_FFMPEG_CONF_OPTS += --disable-decoders \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_SUNXI_FFMPEG_DECODERS)),--enable-decoder=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_SUNXI_FFMPEG_MUXERS)),all)
SUNXI_FFMPEG_CONF_OPTS += --disable-muxers \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_SUNXI_FFMPEG_MUXERS)),--enable-muxer=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_SUNXI_FFMPEG_DEMUXERS)),all)
SUNXI_FFMPEG_CONF_OPTS += --disable-demuxers \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_SUNXI_FFMPEG_DEMUXERS)),--enable-demuxer=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_SUNXI_FFMPEG_PARSERS)),all)
SUNXI_FFMPEG_CONF_OPTS += --disable-parsers \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_SUNXI_FFMPEG_PARSERS)),--enable-parser=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_SUNXI_FFMPEG_BSFS)),all)
SUNXI_FFMPEG_CONF_OPTS += --disable-bsfs \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_SUNXI_FFMPEG_BSFS)),--enable-bsfs=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_SUNXI_FFMPEG_PROTOCOLS)),all)
SUNXI_FFMPEG_CONF_OPTS += --disable-protocols \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_SUNXI_FFMPEG_PROTOCOLS)),--enable-protocol=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_SUNXI_FFMPEG_FILTERS)),all)
SUNXI_FFMPEG_CONF_OPTS += --disable-filters \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_SUNXI_FFMPEG_FILTERS)),--enable-filter=$(x))
endif

ifeq ($(BR2_PACKAGE_SUNXI_FFMPEG_INDEVS),y)
SUNXI_FFMPEG_CONF_OPTS += --enable-indevs
else
SUNXI_FFMPEG_CONF_OPTS += --disable-indevs
endif

ifeq ($(BR2_PACKAGE_SUNXI_FFMPEG_OUTDEVS),y)
SUNXI_FFMPEG_CONF_OPTS += --enable-outdevs
else
SUNXI_FFMPEG_CONF_OPTS += --disable-outdevs
endif

ifeq ($(BR2_TOOLCHAIN_HAS_THREADS),y)
SUNXI_FFMPEG_CONF_OPTS += --enable-pthreads
else
SUNXI_FFMPEG_CONF_OPTS += --disable-pthreads
endif

ifeq ($(BR2_PACKAGE_ZLIB),y)
SUNXI_FFMPEG_CONF_OPTS += --enable-zlib
SUNXI_FFMPEG_DEPENDENCIES += zlib
else
SUNXI_FFMPEG_CONF_OPTS += --disable-zlib
endif

ifeq ($(BR2_PACKAGE_BZIP2),y)
SUNXI_FFMPEG_CONF_OPTS += --enable-bzlib
SUNXI_FFMPEG_DEPENDENCIES += bzip2
else
SUNXI_FFMPEG_CONF_OPTS += --disable-bzlib
endif

ifeq ($(BR2_PACKAGE_OPENSSL),y)
# openssl isn't license compatible with GPL
ifeq ($(BR2_PACKAGE_SUNXI_FFMPEG_GPL)x$(BR2_PACKAGE_SUNXI_FFMPEG_NONFREE),yx)
SUNXI_FFMPEG_CONF_OPTS += --disable-openssl
else
SUNXI_FFMPEG_CONF_OPTS += --enable-openssl
SUNXI_FFMPEG_DEPENDENCIES += openssl
endif
else
SUNXI_FFMPEG_CONF_OPTS += --disable-openssl
endif

ifeq ($(BR2_PACKAGE_LIBVORBIS),y)
SUNXI_FFMPEG_DEPENDENCIES += libvorbis
SUNXI_FFMPEG_CONF_OPTS += \
	--enable-libvorbis \
	--enable-muxer=ogg \
	--enable-encoder=libvorbis
endif

ifeq ($(BR2_PACKAGE_LIBVA),y)
SUNXI_FFMPEG_CONF_OPTS += --enable-vaapi
SUNXI_FFMPEG_DEPENDENCIES += libva
else
SUNXI_FFMPEG_CONF_OPTS += --disable-vaapi
endif

ifeq ($(BR2_PACKAGE_OPUS),y)
SUNXI_FFMPEG_CONF_OPTS += --enable-libopus
SUNXI_FFMPEG_DEPENDENCIES += opus
else
SUNXI_FFMPEG_CONF_OPTS += --disable-libopus
endif

ifeq ($(BR2_PACKAGE_LIBVPX),y)
SUNXI_FFMPEG_CONF_OPTS += --enable-libvpx
SUNXI_FFMPEG_DEPENDENCIES += libvpx
else
SUNXI_FFMPEG_CONF_OPTS += --disable-libvpx
endif

# ffmpeg freetype support require fenv.h which is only
# available/working on glibc.
# The microblaze variant doesn't provide the needed exceptions
ifeq ($(BR2_PACKAGE_FREETYPE)$(BR2_TOOLCHAIN_USES_GLIBC)x$(BR2_microblaze),yyx)
SUNXI_FFMPEG_CONF_OPTS += --enable-libfreetype
SUNXI_FFMPEG_DEPENDENCIES += freetype
else
SUNXI_FFMPEG_CONF_OPTS += --disable-libfreetype
endif

ifeq ($(BR2_PACKAGE_FONTCONFIG),y)
SUNXI_FFMPEG_CONF_OPTS += --enable-fontconfig
SUNXI_FFMPEG_DEPENDENCIES += fontconfig
else
SUNXI_FFMPEG_CONF_OPTS += --disable-fontconfig
endif

ifeq ($(BR2_PACKAGE_X264)$(BR2_PACKAGE_SUNXI_FFMPEG_GPL),yy)
SUNXI_FFMPEG_CONF_OPTS += --enable-libx264
SUNXI_FFMPEG_DEPENDENCIES += x264
else
SUNXI_FFMPEG_CONF_OPTS += --disable-libx264
endif

ifeq ($(BR2_X86_CPU_HAS_MMX),y)
SUNXI_FFMPEG_CONF_OPTS += --enable-yasm
SUNXI_FFMPEG_DEPENDENCIES += host-yasm
else
SUNXI_FFMPEG_CONF_OPTS += --disable-yasm
SUNXI_FFMPEG_CONF_OPTS += --disable-mmx
endif

ifeq ($(BR2_X86_CPU_HAS_SSE),y)
SUNXI_FFMPEG_CONF_OPTS += --enable-sse
else
SUNXI_FFMPEG_CONF_OPTS += --disable-sse
endif

ifeq ($(BR2_X86_CPU_HAS_SSE2),y)
SUNXI_FFMPEG_CONF_OPTS += --enable-sse2
else
SUNXI_FFMPEG_CONF_OPTS += --disable-sse2
endif

ifeq ($(BR2_X86_CPU_HAS_SSE3),y)
SUNXI_FFMPEG_CONF_OPTS += --enable-sse3
else
SUNXI_FFMPEG_CONF_OPTS += --disable-sse3
endif

ifeq ($(BR2_X86_CPU_HAS_SSSE3),y)
SUNXI_FFMPEG_CONF_OPTS += --enable-ssse3
else
SUNXI_FFMPEG_CONF_OPTS += --disable-ssse3
endif

ifeq ($(BR2_X86_CPU_HAS_SSE4),y)
SUNXI_FFMPEG_CONF_OPTS += --enable-sse4
else
SUNXI_FFMPEG_CONF_OPTS += --disable-sse4
endif

ifeq ($(BR2_X86_CPU_HAS_SSE42),y)
SUNXI_FFMPEG_CONF_OPTS += --enable-sse42
else
SUNXI_FFMPEG_CONF_OPTS += --disable-sse42
endif

ifeq ($(BR2_X86_CPU_HAS_AVX),y)
SUNXI_FFMPEG_CONF_OPTS += --enable-avx
else
SUNXI_FFMPEG_CONF_OPTS += --disable-avx
endif

# Explicitly disable everything that doesn't match for ARM
# FFMPEG "autodetects" by compiling an extended instruction via AS
# This works on compilers that aren't built for generic by default
ifeq ($(BR2_ARM_CPU_ARMV4),y)
SUNXI_FFMPEG_CONF_OPTS += --disable-armv5te
endif
ifeq ($(BR2_ARM_CPU_ARMV6)$(BR2_ARM_CPU_ARMV7A),y)
SUNXI_FFMPEG_CONF_OPTS += --enable-armv6
else
SUNXI_FFMPEG_CONF_OPTS += --disable-armv6 --disable-armv6t2
endif
ifeq ($(BR2_ARM_CPU_HAS_VFPV2),y)
SUNXI_FFMPEG_CONF_OPTS += --enable-vfp
else
SUNXI_FFMPEG_CONF_OPTS += --disable-vfp
endif
ifeq ($(BR2_ARM_CPU_HAS_NEON),y)
SUNXI_FFMPEG_CONF_OPTS += --enable-neon
endif

ifeq ($(BR2_MIPS_SOFT_FLOAT),y)
SUNXI_FFMPEG_CONF_OPTS += \
	--disable-mipsfpu
else
SUNXI_FFMPEG_CONF_OPTS += \
	--enable-mipsfpu
endif

ifeq ($(BR2_mips_32r2),y)
SUNXI_FFMPEG_CONF_OPTS += \
	--enable-mips32r2
else
SUNXI_FFMPEG_CONF_OPTS += \
	--disable-mips32r2
endif

ifeq ($(BR2_mips_64r2),y)
SUNXI_FFMPEG_CONF_OPTS += \
	--enable-mipsdspr1 \
	--enable-mipsdspr2
else
SUNXI_FFMPEG_CONF_OPTS += \
	--disable-mipsdspr1 \
	--disable-mipsdspr2
endif

ifeq ($(BR2_POWERPC_CPU_HAS_ALTIVEC),y)
SUNXI_FFMPEG_CONF_OPTS += --enable-altivec
else
SUNXI_FFMPEG_CONF_OPTS += --disable-altivec
endif

ifeq ($(BR2_STATIC_LIBS),)
SUNXI_FFMPEG_CONF_OPTS += --enable-pic
else
SUNXI_FFMPEG_CONF_OPTS += --disable-pic
endif

SUNXI_FFMPEG_CONF_OPTS += $(call qstrip,$(BR2_PACKAGE_SUNXI_FFMPEG_EXTRACONF))

ifneq ($(call qstrip,$(BR2_GCC_TARGET_CPU)),)
SUNXI_FFMPEG_CONF_OPTS += --cpu=$(BR2_GCC_TARGET_CPU)
else ifneq ($(call qstrip,$(BR2_GCC_TARGET_ARCH)),)
SUNXI_FFMPEG_CONF_OPTS += --cpu=$(BR2_GCC_TARGET_ARCH)
endif

# Override SUNXI_FFMPEG_CONFIGURE_CMDS: FFmpeg does not support --target and others
define SUNXI_FFMPEG_CONFIGURE_CMDS
	(cd $(SUNXI_FFMPEG_SRCDIR) && rm -rf config.cache && \
	$(TARGET_CONFIGURE_OPTS) \
	$(TARGET_CONFIGURE_ARGS) \
	$(SUNXI_FFMPEG_CONF_ENV) \
	./configure \
		--enable-cross-compile \
		--cross-prefix=$(TARGET_CROSS) \
		--sysroot=$(STAGING_DIR) \
		--host-cc="$(HOSTCC)" \
		--arch=$(BR2_ARCH) \
		--target-os="linux" \
		--disable-stripping \
		--pkg-config="$(PKG_CONFIG_HOST_BINARY)" \
		$(SHARED_STATIC_LIBS_OPTS) \
		$(SUNXI_FFMPEG_CONF_OPTS) \
	)
endef

$(eval $(autotools-package))
