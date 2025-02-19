osname=$(subst ganeti-instance-,,$(PACKAGE))
osdir=$(OS_DIR)/$(osname)
variantsdir=$(DESTDIR)$(VARIANTSDIR)

dist_os_SCRIPTS = create import export rename verify
dist_os_DATA = ganeti_api_version parameters.list
os_DATA = common.sh

dist_doc_DATA = COPYING NEWS README

exampledir = $(docdir)/examples

dist_example_DATA = \
	examples/dynamic.scm \
	examples/config-base.scm \
	examples/dynamic-lvm.scm \
	examples/dynamic-btrfs.scm \
	examples/generic.scm

EXTRA_DIST = \
	common.sh.in

do_subst = sed \
	-e 's,[@]localstatedir[@],$(localstatedir),g' \
	-e 's,[@]BLOCKDEV[@],$(BLOCKDEV),g' \
	-e 's,[@]GUIX[@],$(GUIX),g' \
	-e 's,[@]GCROOTSDIR[@],$(GCROOTSDIR),g' \
	-e 's,[@]VARIANTSDIR[@],$(VARIANTSDIR),g' \
	-e 's,[@]MOUNT[@],$(MOUNT),g' \
	-e 's,[@]UMOUNT[@],$(UMOUNT),g' \
	-e 's,[@]WIPEFS[@],$(WIPEFS),g' \
	-e 's,[@]FALLOCATE[@],$(FALLOCATE),g' \
	-e 's,[@]MKSWAP[@],$(MKSWAP),g' \
	-e 's,[@]CHATTR[@],$(CHATTR),g' \
	-e 's,[@]JQ[@],$(JQ),g' \
	-e 's,[@]PARTED[@],$(PARTED),g' \
	-e 's,[@]BTRFS[@],$(BTRFS),g' \
	-e 's,[@]SFDISK[@],$(SFDISK),g' \
	-e 's,[@]KPARTX[@],$(KPARTX),g' \
	-e 's,[@]PVCREATE[@],$(PVCREATE),g' \
	-e 's,[@]VGCREATE[@],$(VGCREATE),g' \
	-e 's,[@]VGCREATE[@],$(VGCHANGE),g' \
	-e 's,[@]VGREMOVE[@],$(VGREMOVE),g' \
	-e 's,[@]LVCREATE[@],$(LVCREATE),g' \
	-e 's,[@]LOSETUP[@],$(LOSETUP),g' \
	-e 's,[@]LSBLK[@],$(LSBLK),g' \
	-e 's,[@]BLKID[@],$(BLKID),g' \
	-e 's,[@]CRYPTSETUP[@],$(CRYPTSETUP),g'

common.sh: common.sh.in Makefile
	$(do_subst) < $< > $@

# End users should place variants.list in $variantsdir.
install-exec-local:
	$(MKDIR_P) $(osdir)
	$(LN_S) $(variantsdir)/variants.list $(osdir)/variants.list

CLEANFILES = common.sh
