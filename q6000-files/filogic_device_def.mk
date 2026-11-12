
# ===== iKuai Q6000 eMMC (custom) =====
define Device/ikuai_q6000-emmc
  DEVICE_VENDOR := iKuai
  DEVICE_MODEL := Q6000 (eMMC)
  DEVICE_DTS := mt7986a-ikuai-q6000-emmc
  DEVICE_DTS_DIR := ../dts
  DEVICE_DTC_FLAGS := --pad 4096
  DEVICE_DTS_LOADADDR := 0x4a000000
  KERNEL_LOADADDR := 0x48000000
  KERNEL := kernel-bin | lzma | \
        fit lzma $$(KDIR)/image-$$(firstword $$(DEVICE_DTS)).dtb
  KERNEL_INITRAMFS := kernel-bin | lzma | \
        fit lzma $$(KDIR)/image-$$(firstword $$(DEVICE_DTS)).dtb with-initrd
  IMAGES := sysupgrade.bin
  IMAGE/sysupgrade.bin := append-kernel | append-rootfs | pad-rootfs | \
        check-size | append-metadata
  DEVICE_PACKAGES := kmod-mt7915e kmod-mt7986-firmware kmod-usb3 \
        kmod-usb-storage kmod-fs-ext4 kmod-fs-f2fs e2fsprogs f2fsck mkf2fs \
        blkid block-mount
  SUPPORTED_DEVICES += ikuai,q6000-emmc
endef
TARGET_DEVICES += ikuai_q6000-emmc
