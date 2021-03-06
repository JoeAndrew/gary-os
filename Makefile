#!/usr/bin/make --makefile
################################################################################
# GaryOS :: Primary Makefile
################################################################################

override GARYOS_DIR := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))

########################################

ifneq ($(wildcard $(GARYOS_DIR)/.bashrc),)
export HOME	:= $(GARYOS_DIR)
endif
override CHROOT	:= -g

override C	?= $(GARYOS_DIR)
override S	?= $(GARYOS_DIR)/sources
override O	?= $(GARYOS_DIR)/build
override A	?= $(GARYOS_DIR)/artifacts
override P	?= gary-os

########################################

.NOTPARALLEL:
.POSIX:
.SUFFIXES:

################################################################################

override TITLE	:= \e[1;32m
override STATE	:= \e[0;35m
override HOWTO	:= \e[0;36m
override NOTES	:= \e[0;33m
override OTHER	:= \e[1;34m
override RESET	:= \e[0;37m

override ECHO	:= echo -en
override MARKER	:= $(ECHO) "$(OTHER)"; printf "~%.0s" {1..80}; $(ECHO) "$(RESET)\n"
override PRINTF	:= printf "$(TITLE)%-45.45s$(RESET) $(HOWTO)%s$(RESET) $(STATE)%s$(RESET)\n"

########################################

#NOTE: KEEP THIS OUTPUT TO LESS THAN 80 CHARACTERS WIDE

.PHONY: usage
usage:
	@$(MARKER)
	@$(ECHO) "$(NOTES)>>> GARYOS BUILD SYSTEM <<<$(RESET)\n"
	@$(MARKER)
	@$(ECHO) "\n"
	@$(ECHO) "$(STATE)This Makefile is a wrapper to the \"_system\" script, and has just a few targets:$(RESET)\n"
	@$(ECHO) "\n"
	@$(PRINTF) "Update Current System (Interactively):"	"$(MAKE) update"
	@$(ECHO) "\n"
	@$(PRINTF) "Information Lookup (Package Data):"		"$(MAKE) {package_list}"
	@$(PRINTF) "Information Lookup (Package Search):"	"$(MAKE) {search_list}"
	@$(PRINTF) "Information Lookup (Gentoo Bug URL):"	"$(MAKE) {bug_ids}"
	@$(ECHO) "\n"
	@$(PRINTF) "Chroot Build (Initial):"			"$(MAKE) init"
	@$(PRINTF) "Chroot Build (Update Only):"		"$(MAKE) doit" "<tiny>"
	@$(PRINTF) "Chroot Build (Complete Rebuild):"		"$(MAKE) redo"
	@$(PRINTF) "Chroot Build (Configuration):"		"$(MAKE) edit"
	@$(ECHO) "\n"
	@$(PRINTF) "Chroot Shell (Bash):"			"$(MAKE) shell"
	@$(ECHO) "\n"
	@$(PRINTF) "Chroot Complete (Unmount Cleanup):"		"$(MAKE) umount"
	@$(ECHO) "\n"
	@$(PRINTF) "Initramfs Build (Chroot Reset):"		"$(MAKE) clean"
	@$(PRINTF) "Initramfs Build (Chroot Create):"		"$(MAKE) release"
	@$(PRINTF) "Initramfs Build (Chroot Initrd):"		"$(MAKE) initrd"
	@$(PRINTF) "Initramfs System (Live Reset):"		"$(MAKE) O=/ clean"
	@$(PRINTF) "Initramfs System (Live Create):"		"$(MAKE) O=/ release"
	@$(PRINTF) "Initramfs System (Live Initrd):"		"$(MAKE) O=/ initrd"
	@$(PRINTF) "Initramfs System (Live Unpack):"		"$(MAKE) O=/ unpack"
	@$(PRINTF) "Initramfs System (Live Install):"		"$(MAKE) O=/ install"
ifneq ($(findstring help,$(MAKECMDGOALS)),)
	@$(ECHO) "\n"
	@$(ECHO) "$(STATE)There are also \"initramfs\" pass-through targets, for advanced use:$(RESET)\n"
	@$(ECHO) "\n"
	@$(PRINTF) "Distribution Prepare (Internal Only):"	"_prepare_*"
	@$(PRINTF) "Distribution Release (Internal Only):"	"_release_*"
endif
	@$(ECHO) "\n"
	@$(ECHO) "$(STATE)All of the targets generally run non-interactively, except \"update\" and \"shell\".$(RESET)\n"
	@$(ECHO) "\n"
	@$(ECHO) "$(STATE)Use these variables to change the directories and packages:$(RESET)\n"
	@$(ECHO) "\n"
	@$(PRINTF) "Configuration Directory:"			"C=\"$(C)\""
	@$(PRINTF) "Sources Directory:"				"S=\"$(S)\""
	@$(PRINTF) "Output Directory:"				"O=\"$(O)\""
	@$(PRINTF) "Artifacts Directory:"			"A=\"$(A)\""
	@$(PRINTF) "Package List:"				"P=\"$(P)\""
	@$(ECHO) "\n"
	@$(ECHO) "$(STATE)A full example to initialize a new chroot build would be:$(RESET)\n"
	@$(ECHO) "\n"
	@$(ECHO) "$(HOWTO)$(MAKE) init C=\"$(C)\" S=\"$(S)\" O=\"$(O)\" A=\"$(A)\" P=\"$(P)\"$(RESET)\n"
	@$(ECHO) "\n"
	@$(ECHO) "$(STATE)To do a complete build in the current directory using the defaults:$(RESET)\n"
	@$(ECHO) "\n"
	@$(ECHO) "$(HOWTO)$(MAKE) all $(NOTES)(same as: $(MAKE) init doit redo edit release)$(RESET)\n"
	@$(ECHO) "\n"
	@$(ECHO) "$(STATE)For more options and build tools, use the \"_system\" script directly:$(RESET)\n"
	@$(ECHO) "\n"
	@$(ECHO) "$(HOWTO)$(MAKE) help | less$(RESET)\n"
	@$(ECHO) "\n"
	@$(ECHO) "$(STATE)Both methods are supported ways of using the GaryOS build system.$(RESET)\n"
	@$(ECHO) "\n"
	@$(MARKER)
	@$(ECHO) "$(NOTES)>>> HAPPY HACKING! <<<$(RESET)\n"
	@$(MARKER)

########################################

.PHONY: help
help: usage
	SETDIR="$(C)" SOURCE="$(S)" GOSDIR="$(O)" ARTDIR="$(A)" GOSPKG="$(P)" $(C)/gentoo/_system -v -q $(CHROOT)

########################################

.DEFAULT_GOAL := usage
.DEFAULT:
	@$(MARKER)
	@$(ECHO) "$(NOTES)>>> CURRENT SYSTEM PACKAGE LOOKUP: $(@) <<<$(RESET)\n"
	SETDIR="$(C)" SOURCE="$(S)" GOSDIR="$(O)" ARTDIR="$(A)" GOSPKG="$(P)" $(C)/gentoo/_system -q -l "$(@)"
	@$(ECHO) "\n"
	@$(ECHO) "$(NOTES)>>> CHROOT SYSTEM PACKAGE LOOKUP: $(@) <<<$(RESET)\n"
	SETDIR="$(C)" SOURCE="$(S)" GOSDIR="$(O)" ARTDIR="$(A)" GOSPKG="$(P)" $(C)/gentoo/_system -q $(CHROOT) -l "$(@)"
	@$(MARKER)

################################################################################

.PHONY: update
update:
	SETDIR="$(C)" SOURCE="$(S)" GOSDIR="$(O)" ARTDIR="$(A)" GOSPKG="$(P)" $(C)/gentoo/_system $(CHROOT)
	SETDIR="$(C)" SOURCE="$(S)" GOSDIR="$(O)" ARTDIR="$(A)" GOSPKG="$(P)" $(C)/gentoo/_system $(CHROOT) -u

########################################

.PHONY: package_list
package_list: .DEFAULT

########################################

.PHONY: all
all: init doit redo edit release

.PHONY: tiny
tiny:
	SETDIR="$(C)" SOURCE="$(S)" GOSDIR="$(O)" ARTDIR="$(A)" GOSPKG="$(P)" $(C)/gentoo/_system $(CHROOT) -m -/

########################################

.PHONY: init
init:
	SETDIR="$(C)" SOURCE="$(S)" GOSDIR="$(O)" ARTDIR="$(A)" GOSPKG="$(P)" $(C)/gentoo/_system $(CHROOT) -0

.PHONY: doit
doit:
	SETDIR="$(C)" SOURCE="$(S)" GOSDIR="$(O)" ARTDIR="$(A)" GOSPKG="$(P)" $(C)/gentoo/_system $(CHROOT) -/

.PHONY: redo
redo:
	SETDIR="$(C)" SOURCE="$(S)" GOSDIR="$(O)" ARTDIR="$(A)" GOSPKG="$(P)" $(C)/gentoo/_system $(CHROOT) -1

.PHONY: edit
edit:
	SETDIR="$(C)" SOURCE="$(S)" GOSDIR="$(O)" ARTDIR="$(A)" GOSPKG="$(P)" $(C)/gentoo/_system $(CHROOT) -2

########################################

.PHONY: shell
shell:
	SETDIR="$(C)" SOURCE="$(S)" GOSDIR="$(O)" ARTDIR="$(A)" GOSPKG="$(P)" $(C)/gentoo/_system $(CHROOT) -s

########################################

.PHONY: umount
umount:
	SETDIR="$(C)" SOURCE="$(S)" GOSDIR="$(O)" ARTDIR="$(A)" GOSPKG="$(P)" $(C)/gentoo/_system $(CHROOT) -z

########################################

.PHONY: clean
clean:
	SETDIR="$(C)" SOURCE="$(S)" GOSDIR="$(O)" ARTDIR="$(A)" GOSPKG="$(P)" $(C)/gentoo/_system $(CHROOT) _release_reset

.PHONY: release
release:
	SETDIR="$(C)" SOURCE="$(S)" GOSDIR="$(O)" ARTDIR="$(A)" GOSPKG="$(P)" $(C)/gentoo/_system $(CHROOT) _release_ramfs

.PHONY: initrd
initrd:
	SETDIR="$(C)" SOURCE="$(S)" GOSDIR="$(O)" ARTDIR="$(A)" GOSPKG="$(P)" $(C)/gentoo/_system $(CHROOT) _release_initrd

.PHONY: unpack
unpack:
	SETDIR="$(C)" SOURCE="$(S)" GOSDIR="$(O)" ARTDIR="$(A)" GOSPKG="$(P)" $(C)/gentoo/_system $(CHROOT) _release_unpack

.PHONY: install
install:
	SETDIR="$(C)" SOURCE="$(S)" GOSDIR="$(O)" ARTDIR="$(A)" GOSPKG="$(P)" $(C)/gentoo/_system $(CHROOT) _release_install

########################################

.PHONY: _prepare_%
_prepare_%:
	SETDIR="$(C)" SOURCE="$(S)" GOSDIR="$(O)" ARTDIR="$(A)" GOSPKG="$(P)" $(C)/gentoo/_system $(CHROOT) _prepare_$(*)

.PHONY: _release_%
_release_%:
	SETDIR="$(C)" SOURCE="$(S)" GOSDIR="$(O)" ARTDIR="$(A)" GOSPKG="$(P)" $(C)/gentoo/_system $(CHROOT) _release_$(*)

################################################################################

.PHONY: readme
readme:
	@grep -E "^[#*]"					$(GARYOS_DIR)/README.md

.PHONY: readme-all
readme-all: readme
	@$(ECHO) "\n"
	@grep -E "^[[:space:]]+[*][ ][[][A-Z0-9].+[]]$$"	$(GARYOS_DIR)/README.md
	@$(ECHO) "\n"
	@grep -E "^[[#*][#*A-Z0-9 ]"				$(GARYOS_DIR)/README.md
	@$(ECHO) "\n"
	@grep -E "^[#*]"					$(GARYOS_DIR)/LICENSE.md

################################################################################
# End Of File
################################################################################
