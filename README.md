# Welcome to GaryOS (gary-os)

********************************************************************************

![GaryOS Icon](artifacts/images/icon.png "GaryOS Icon")
"The one file that does it all."

  * Latest: GaryOS v3.0 ([64-bit]) ([32-bit]) ([Packages]) ([Notes]) ([License])
  * Homepage: [https://github.com/garybgenett/gary-os](https://github.com/garybgenett/gary-os)
  * Download: [https://sourceforge.net/projects/gary-os](https://sourceforge.net/projects/gary-os)

[Homepage]: https://github.com/garybgenett/gary-os
[Download]: https://sourceforge.net/projects/gary-os/files
[Readme]: https://github.com/garybgenett/gary-os/blob/master/README.md
[License]: https://github.com/garybgenett/gary-os/blob/master/LICENSE.md

[Gary B. Genett]: http://www.garybgenett.net/resume.html
[gary-os@garybgenett.net]: mailto:gary-os@garybgenett.net?subject=GaryOS%20Submission&body=Why%20I%20love%20GaryOS%20so%20much...

********************************************************************************

  * [Overview]
    * [Quick Start]
    * [Requirements]
    * [Contact & Support]
    * [Acknowledgements & Reviews]
    * [Contributing]
  * [Information]
    * [Design]: [Goals], [Advantages], [Limitations], [History]
    * [Details]: [Versioning], [Structure], [Tools], [Ecosystem]
  * [Instructions]
    * [Booting]
        * [USB Drive & Grub Rescue]
        * [Windows Dual-Boot]
        * [PXE Boot]
    * [Running]
        * [Forensics & Recovery]
        * [Networking Configuration]
        * [Graphical Interface]
    * [Building]
        * [Live Update]
        * [Hard Drive Install]
  * [Version History]
    * [2015-03-16 v3.0 21811b59a8484b2a6b73e0c5277f23c50a0141dc.0]
    * [2014-06-19 v2.0 873ca4a3a4e6ff41e510dbcf2e0fe549fb23474d.0]
    * [2014-03-13 v1.1 95ad4fd257697618bae7402d4bc3a27499035d30.4]
    * [2014-02-28 v1.0 95ad4fd257697618bae7402d4bc3a27499035d30.3]
    * [2014-02-24 v0.3 95ad4fd257697618bae7402d4bc3a27499035d30.2]
    * [2014-02-13 v0.2 95ad4fd257697618bae7402d4bc3a27499035d30.1]
    * [2014-02-09 v0.1 95ad4fd257697618bae7402d4bc3a27499035d30.0]

********************************************************************************

# Overview #####################################################################
[Overview]: #overview

GaryOS is an entire GNU/Linux system in a single bootable file.  It is also
a build system to produce both the bootable file and entire installations.

The booted system consists of a Linux kernel and a Funtoo (based on Gentoo)
initramfs.  It is generated using a customized Funtoo configuration with
a modified Linux kernel configuration (based on the latest Grml default).  The
included build system is entirely specialized for the task.  GaryOS can build
itself from within itself.

There are no major projects which take this same approach on this scale.  The
result is a self-contained file that is more flexible and capable than other
live systems.

Primary features:

  * Comprehensive: complete and optimized Funtoo system with GNU toolchain
  * Invisible: resides completely in memory and does not need media after boot
  * Safe: no hard drives are mounted and swap is disabled
  * Flexible: can be used anywhere a Linux kernel can (USB, PXE, etc.)
  * Portable: small footprint can easily fit on any partition
  * Usable: upgrades are as simple as replacing the file
  * Adaptable: supports source-based package options and custom builds
  * Complete: bootloader and direct-to-disk install of a ready-to-use system
  * Fast: everything lives in memory, so all operations happen very rapidly

The goal of GaryOS is to provide a single, simple file which can be
conveniently used for system rescue or installation, or as a temporary
workstation for productivity or learning.  In parallel with this is the
objective of maintaining a usable build system to create GaryOS or other custom
systems.

![GaryOS CLI Screenshot](artifacts/images/screenshot_cli.png "GaryOS CLI Screenshot")

![GaryOS GUI Screenshot](artifacts/images/screenshot_gui.png "GaryOS GUI Screenshot")

## Quick Start #################################################################
[Quick Start]: #quick-start

GaryOS releases are not stored in the Git repository, due to size.  The first
step is to download the latest [Kernel].

The simplest way to try GaryOS is using the [Qemu] virtual machine emulator,
which runs on all major platforms.  Once installed, you can boot GaryOS
directly using something like:

  * `qemu-system-x86_64 -m 4096 -kernel [...]/gary-os-[...].kernel`

To use it "for real", follow the brief instructions in the [USB Drive & Grub
Rescue] or [Windows Dual-Boot] sections, depending on whether your current
platform is Linux or Windows.  Apple platforms are not supported.

For advanced users with an existing bootloader (such as Grub), you can add an
entry pointing to the file on disk.  In Grub, this looks something like:

  * `linux (hd0,1)/boot/gary-os-[...].kernel`

All the standard Linux kernel options/parameters are valid.  For example, the
amount of memory Linux allocates to itself can be specified as usual:

  * `linux (hd0,1)/boot/gary-os-[...].kernel mem=4096m`

Once booted, the entire system resides in memory, and any media used to boot it
is no longer necessary.

  * Log in as `root` with password `gary-os`.

After use, the system may simply be powered off.  There is no need to shutdown
GaryOS, since it will boot completely fresh from the file each time.

## Requirements ################################################################
[Requirements]: #requirements

A 64-bit x86 CPU is required.  GaryOS is not built for any other platforms.
Intel and AMD x86 processors are by far the most common for desktop and laptop
computers, which is what GaryOS was designed for.  Due to fundamental internal
hardware differences, and the lack of an available development system, Apple
platforms are not supported.

The booted system requires at least 4GB of RAM.  Some of the advanced features
and uses require additional memory, and 8GB is recommended.

The GaryOS kernel is roughly ~750MB in size, and at least 1GB of storage is
recommended.  All efforts have been made to make GaryOS as compact as possible,
but required Linux packages continue to grow over time, such as these:

  * GCC
  * Linux firmware
  * Grub
  * Python (still needs both v2.x and v3.x for a complete system)
  * Glibc

This list is not meant to be critical, and is only provided for transparency.
The work necessary to keep the distribution compact is ongoing.

Twice during boot, at initial kernel load and initramfs decompression, GaryOS
can appear to hang as the kernel and initramfs are loaded into memory.  This is
normal, and only takes a few moments each.  It uses the standard Linux
infrastructure which does not display any progress.  The actual boot time is
just as fast as other live systems, but the lack of output can be unnerving.
Thus, the final requirement is a tad bit of patience.

## Contact & Support ###########################################################
[Contact & Support]: #contact--support

[Gary B. Genett] is the sole developer and maintainer of GaryOS.  It is
a personal project with aspirations of recognition as an actual distribution,
however misguided.

There is no documentation other than this file and the usage output of the
build scripts.  The uses outlined in the [Instructions] section are the
official "happy paths", and are tested and supported.

Typing `make` or `make usage` will display the supported uses of the build
system.  Advanced uses are documented with `make help`, and are also supported
(but should only be used by those who know what they are doing).  When
reporting issues with the build system, please include the `_gentoo.log` file
from the `build` directory.

While there appears to be some adoption of GaryOS, it is not yet enough to
warrant a formal issue tracker.  For any issues, please contact the author
directly at: [gary-os@garybgenett.net]

GaryOS is very flexible, and both the kernel and build system can be used for
a wide range of applications.  Other uses of all the GaryOS tooling are
encouraged, and the author would be glad to hear about any unique or creative
ways they are employed.  For some ideas, check out the
"[gentoo/sets/\_gary-os]" package set, which outlines some of the author's
personal uses along with the steps used to test and validate GaryOS each
release.

The author will also take you out on the town if you schedule time to geek out
with him in the Seattle area.

## Acknowledgements & Reviews ##################################################
[Acknowledgements & Reviews]: #acknowledgements--reviews

GaryOS has maintained a steady stream of downloads since its inception in 2014.
As of September 2019, it has maintained an average of ~90 downloads a month
over its lifetime, with notable spikes of ~2K, ~0.6K and ~1.5K in March 2018,
January 2019 and September 2019, respectively.  Activity is concentrated in the
U.S. and Europe, but there is clearly a worldwide audience.

  * [https://sourceforge.net/projects/gary-os/files/stats/timeline?dates=2014-02-28+to+2038-01-19](https://sourceforge.net/projects/gary-os/files/stats/timeline?dates=2014-02-28+to+2038-01-19)
  * [https://sourceforge.net/projects/gary-os/files/stats/map?dates=2014-02-28+to+2038-01-19](https://sourceforge.net/projects/gary-os/files/stats/map?dates=2014-02-28+to+2038-01-19)

Despite the relatively small user base, modest infrastructure, and infrequent
release schedule, GaryOS has managed to receive some official acknowledgment.

Most notably, it has been included in the official Gentoo family tree:

![Gentoo Ecosystem](artifacts/archive/gentoo-18.01.svg.png "Gentoo Ecosystem")

*Source: [https://github.com/gentoo/gentoo-ecosystem/blob/master/gentoo-18.01.svg](https://github.com/gentoo/gentoo-ecosystem/blob/master/gentoo-18.01.svg)*

It is also listed on the official Funtoo ecosystem page:

[https://funtoo.org/Gentoo_Ecosystem](https://funtoo.org/Gentoo_Ecosystem)

There is a Softpedia review of v2.0 from a few years ago, which is interesting
because it means somebody took the time to boot it up and play with it:

[https://linux.softpedia.com/get/Linux-Distributions/GaryOS-103629.shtml](https://linux.softpedia.com/get/Linux-Distributions/GaryOS-103629.shtml)

Snapshots of all discovered references to GaryOS are kept in the
"[artifacts/archive]" directory.  Please use [Contact & Support] to notify the
author of any other acknowledgements you may find, including you having read
this far.

<!-- WORK: http://without-systemd.org/wiki/index.php/Linux_distributions_without_systemd/unlisted -->

## Contributing ################################################################
[Contributing]: #contributing

This is very much a personal project, but any contributions are welcome and
will be publicly acknowledged.  For the time being, the best way is to submit
patches using the information in [Contact & Support].  Submissions should
include the commit hash used to create the patch.

For best results, use the `git format-patch` command.  Bonus points for using
the pre-made function in the "[.bashrc]" file in the repository, like so:

  * `[...]/.bashrc git-patch [...]`

The author is passionate about who you are, your ideas and what you manifest in
the world.  All other attributes and circumstances are irrelevant
considerations here.  We are all just human beings.

It seems to be a current trend that opensource projects are adopting equality
and conduct statements.  These are the two best documents the author could
find, the latter of which was suggested by GitHub, which in turn inspired an
Internet search to find the former:

  * Social Protection & Human Rights Equality and Non-discrimination: [https://socialprotection-humanrights.org/framework/principles/equality-and-non-discrimination](https://socialprotection-humanrights.org/framework/principles/equality-and-non-discrimination)
  * Contributor Covenant Code of Conduct: [https://contributor-covenant.org/version/1/4/code-of-conduct.html](https://contributor-covenant.org/version/1/4/code-of-conduct.html)

Hopefully that covers all the bases.  Let's all just be kind to one another, so
we don't even need documents like these.

********************************************************************************

# Information ##################################################################
[Information]: #information

This collection of sections covers GaryOS and the repository in greater depth,
and is not for the faint of heart.

It is mainly here for completeness.  The most useful information is in the
[Overview] and [Instructions] sections.

## Design ######################################################################
[Design]: #design

GaryOS was not really "designed", per se.  It very much happened organically.
Any lack of production value to the code is a result of that.

Despite not having been designed in the traditional sense, GaryOS does have
clear structure and requirements, along with unique advantages and limitations.
It also has an interesting origin story, like all superheroes.

### Goals ######################################################################
[Goals]: #goals

Here are the guiding principles that keep GaryOS going in a consistent
direction, with a consistent purpose.

Top requirements:

  * All-purpose, multi-OS rescue environment, based on Funtoo
  * Complete system, with all packages installed as they normally would be
  * As close to default as possible, aside from "portage" package build tuning
  * Generic 64-bit build, supporting most modern x86 platforms
  * Bootable from a single kernel file, using initramfs
  * Make Funtoo installation trivial as a live media

Other objectives:

  * Support as many boot methods as possible, such as USB setup and PXE
  * Example configuration/scripts for tuning and maintaining a Funtoo system
  * Foster a DIY (Do It Yourself) approach through good documentation
  * Learning environment for those new to GNU/Linux or Funtoo

Explicit non-goals:

  * Growing bigger than a single kernel file
  * Customization or deep branding of overall system
  * Development of a helper scripts/commands library
  * Alteration of boot or "init" infrastructure
  * Becoming a complete desktop environment

### Advantages #################################################################
[Advantages]: #advantages

The number of live systems, for everything from basic rescue to a full
workstation, is quite staggering.  Many of them are extremely useful and very
well-established.  So, why create another one?

The main differentiators of GaryOS:

  1. A single kernel file is easier to manage and boot than an ISO file
  2. It is a source-based Funtoo system, which is much more powerful than
     binary distributions, like those based on Debian (Grml, Ubuntu, etc.)
  3. Installation of Gentoo/Funtoo can be a bit of work, and having
     a ready-made system can make the process much more approachable

ISO files are the standard method of releasing live distributions, and they
work quite well, overall.  There are a few options for using them:

  1. Write directly to CD/DVD or USB media, each install or upgrade
  2. Use a bootloader, like Grub, which supports booting ISO images
  3. Extract the ISO contents to USB media, and configure everything manually

They do pose some challenges, however:

  1. CDs/DVDs are antiquated, and not as ubiquitous as USB drives
  2. Wiping your USB drive every upgrade makes it more or less single-purpose
  3. Booting directly from an ISO file uses an emulated CD/DVD "loop" drive
     that the OS can use, requiring a small portion of bootloader code to stay
     in memory and for the boot media to stay connected
  4. Extracting everything onto a USB drive preserves other data on the drive
     at the expense of complexity, and upgrades are not trivial

Some distributions, such as Grml, have tools that automate the process of
extracting to USB, which makes the process much simpler.  The drawback is that
these scripts require you to start from a Unix-like system to begin with, and
ultimately they manage rather than remove the complexity.

The GaryOS philosophy is that no complex steps or scripting should be
necessary.  It is a single file, and upgrades are a simple matter of replacing
it.  Once the initial bootloader is configured, it should never need to be
touched again.  GaryOS should be a resident on the media, and not the purpose
of it.  No major live distribution takes this approach or makes these claims.

### Limitations ################################################################
[Limitations]: #limitations

Humans are not perfect, and rarely is anything we create.  While there is great
pride in GaryOS, and the care and attention to detail which goes with it, this
section is to be clear about its shortcomings.  The author wishes to avoid the
appearance of ignorance or negligence by being thoughtfully forthcoming.

General notes:

  * Lack of progress reporting while booting feels very unpolished
  * Portage configuration is tuned more for the author than a general audience

Considerations for the build system:

  * Argument processing is very rudimentary, almost archaic, and non-unique
    environment variables are used heavily for configuration
  * It is essentially just shell scripting, and all that comes with that

General coding style and syntax:

  * The coding style is organic, and not based on any standard guidelines
  * Most of the code is self-explanatory, but there are very few comments
  * Arbitrarily wide number of columns is not POSIX, and requires big monitors
  * Heavy use of tabs, for non-leading space and also mixed with standard
    spaces (a "tab stop" of "8" is required for readability)

Supportability:

  * This is a mostly personal project which the author aspires to update at
    least once a year, but there is not a copious amount of free time with
    which to support and enhance this project
  * The history for the components of this project reside in several different
    personal repositories which are merged together into the public GaryOS Git
    repository (this process is performed by the "[gentoo/\_release]" script),
    meaning that even minor disruptions or inclusion of new items will result
    in a public repository that can not use the "fast-forward" feature of Git
    and will require re-cloning

### History ####################################################################
[History]: #history

The origin of the project was experimentation with the Metro, Buildroot and
BusyBox projects, and Metro in particular.  The goal at the time was to use
Metro to build customized "stage3" files.  As development of the concept
continued, the difference between a "stage3" and a system that could be run
live began to disappear.  An inspired moment of "could the custom stage3 be
used as an initramfs?", and GaryOS was born as a relatively unique live OS.

Perusing the history of this repository and the [Download] directory will
provide pretty good visibility into those floundering beginnings.

Until [v1.1], it was still mostly a publicly-available experiment and not an
actual project fit for the masses.  That release marked a turning point where
an effort was made towards general usability.  Starting with [v2.0], releases
were made specifically to be utilized by a general audience.  Improvements were
made through [v3.0], but the project remained in an embryonic state.  Both
[v2.0] and [v3.0] were primarily driven by an update in the Portage commit used
to determine the package versions.  In particular, [v3.0] was released mostly
on the self-imposed pressure to put out another release.

In the time from 2015-2019, life took on some big changes for the author, and
GaryOS fell by the wayside.  His own personal system languished until 2017,
when an absolutely necessary update was forced as a matter of being able to
accomplish critical tasks, such as using certain websites.  Another year
whittled by, as infrequent and half-hearted investments where made until
another upgrade in 2018.  Again it took almost a year to perform an upgrade,
and also to complete the efforts towards another actual release of GaryOS.

With the [v4.0] release, a genuine effort was made to upgrade the project to
a production-grade distribution.  Despite over 4 years of release inactivity,
downloads remained consistent, and even experienced a few unexplained spikes.
The build system was switched from Metro to the one being used by the author
for his personal builds, the build system was made much more robust, all the
scripts were cleaned up and documented as much as possible, and a Makefile
was written to make the system more usable.  Tuning of the system was done on
a more granular level, and some non-intrusive branding and polish was added.
Finally, paths to live updating or installation were formalized and wrapped
using the Makefile.  Generally speaking, the final result was designed to be
less "hackish".

At that point in time, upgrades were still taking a year or more to complete.
With the updated build system and release process, work began to decrease the
time between stable builds, and continues today towards v5.0.

The project was not named GaryOS out of any delusions of grandeur or egomania.
It was coined years before its birth by a pair of good friends who jested at
the amount of time and effort spent tuning and customizing a computing
environment.  The author's workstation was jokingly called "Gary OS".

All the heavily personalized tools, configuration and automation are made
possible by the dedicated efforts of thousands of developers worldwide who
build and maintain a plethora of opensource projects.  Since GaryOS is really
nothing more than a thin layer of wrapping and polish on the more mature work
of these projects, it seemed fitting to name the project as such in
a self-deprecating manner.

That final point is worth re-iterating: GaryOS is 95%+ the work of other
projects.  All that has been done is to tie things together in a way that some
may find novel, appealing and useful.

## Details #####################################################################
[Details]: #details

This section outlines the key pieces which make GaryOS tick.  The work will
still pretty much speak for itself, but some explanation of what all the stuff
in this repository is will likely be beneficial to anyone curious enough to
have read this far.

Most of what is needed to use the contents of this repository is contained in
the [Structure] section.

### Versioning #################################################################
[Versioning]: #versioning

Release version numbers are assigned in the spirit of [Semantic Versioning].
However, GaryOS does not provide any APIs, so the full specification does not
apply.  As such, the model used is to update the major version number whenever
the Portage commit is updated.  Minor version numbers are done for updates to
a particular Portage commit as a new release.

A notable exception was [v1.0].  The reason being that was the first version
released as a single kernel file and meant for general use.  The [v1.1] release
was a continuation of that work.  Starting with [v2.0], GaryOS will adhere to
the major/minor system, where each major is a new Portage tree and each minor
is just an update on that same tree.

Major revisions to the GaryOS build system and supporting scripting and
configuration files will also line up with major version numbers.

[Semantic Versioning]: https://semver.org

### Structure ##################################################################
[Structure]: #structure

Here is an overview of the repository contents:

| Directory / File           | Purpose
| :---                       | :---
| [README.md]                | This file.  All the documentation for GaryOS.
| [LICENSE.md]               | The license GaryOS is distributed under.
| [Makefile]                 | Primary starting point for using the build system using the `make` command.
| [\_packages]               | Final package list, including sizes and markers for what is installed versus packaged for the build.
| [\_commit]                 | Solely for author tracking.  Records commit IDs for each of the repositories relevant to the building of GaryOS.
| **Key directories:**       | --
| [linux]                    | Archive of Linux kernel configuration files.
| [gentoo]                   | Entirety of the Funtoo configuration, including the scripts used to build and manage installations.
| [gentoo/\_overlay]         | Funtoo overlay directory.  Used very sparingly, and mostly for fixing broken packages.
| [scripts]                  | Ancillary scripts relevant to GaryOS, such as "[scripts/grub.sh]".
| [artifacts]                | Storage for miscellaneous files used in the initramfs build.
| [artifacts/images]         | Icons, screenshots and the like.
| [artifacts/archive]        | Stash space for files which don't fit elsewhere, including snapshots of [Acknowledgements & Reviews] items.
| **Core files:**            | --
| [.bashrc]                  | Custom Bash configuration file.  Included as an essential scripting library.
| [scripts/grub.sh]          | Generates the [Grub] archive, which contains BIOS and EFI rescue bootloaders, along with a prepared disk image.
| [gentoo/\_system]          | Heart and soul of the build engine.  Creates new installations, and provides maintenance and inspection tooling.
| [gentoo/\_release]         | Does all the initramfs work, customizing and packaging the root filesystem and building the kernel.  Also performs the entire release and publishing process.
| [gentoo/funtoo]            | Contains the commit ID that the Funtoo Portage repository should be "pinned" to.  Ties the Funtoo configuration to a particular version of the Portage tree, which ensures repeatability and stability.
| [gentoo/funtoo.kits]       | Hackish wrapper to the `meta-repo` Portage repository, to ensure proper "pinning".  *(Needs to be incorporated into "ego" upstream.)*
| [gentoo.config]            | Example script for post-build customization of an initramfs.
| [gentoo/.emergent]         | Audit script which validates current Funtoo configuration against Portage tools/output.  Also extracts useful information from the `meta-repo` Portage repository.
| [dwm]                      | Slightly modified DWM configuration file, to make `startx` more usable.
| [gentoo/sets/gary-os]      | Package list for initramfs build.  Also contains custom keywords for tailoring the build.
| [gentoo/sets/\_gary-os]    | Additional packages list, along with scripting instructions/commands for accomplishing various tasks and testing GaryOS.
| **Just for fun:**          | --
| [xclock\_size\_hack.patch] | The author wanted "[gkrellaclock]" to look more like a genuine "xclock", so he did it.  First real experience coding in C.  Created in early 2014 and still in active use.

[README.md]: https://github.com/garybgenett/gary-os/blob/master/README.md
[LICENSE.md]: https://github.com/garybgenett/gary-os/blob/master/LICENSE.md
[Makefile]: https://github.com/garybgenett/gary-os/blob/master/Makefile
[\_packages]: https://github.com/garybgenett/gary-os/blob/master/_packages
[\_commit]: https://github.com/garybgenett/gary-os/blob/master/_commit

[linux]: https://github.com/garybgenett/gary-os/blob/master/linux
[gentoo]: https://github.com/garybgenett/gary-os/blob/master/gentoo
[gentoo/\_overlay]: https://github.com/garybgenett/gary-os/blob/master/gentoo/_overlay
[scripts]: https://github.com/garybgenett/gary-os/blob/master/scripts
[artifacts]: https://github.com/garybgenett/gary-os/blob/master/artifacts
[artifacts/images]: https://github.com/garybgenett/gary-os/blob/master/artifacts/images
[artifacts/archive]: https://github.com/garybgenett/gary-os/blob/master/artifacts/archive

[.bashrc]: https://github.com/garybgenett/gary-os/blob/master/.bashrc
[scripts/grub.sh]: https://github.com/garybgenett/gary-os/blob/master/scripts/grub.sh
[gentoo/\_system]: https://github.com/garybgenett/gary-os/blob/master/gentoo/_system
[gentoo/\_release]: https://github.com/garybgenett/gary-os/blob/master/gentoo/_release
[gentoo/funtoo]: https://github.com/garybgenett/gary-os/blob/master/gentoo/funtoo
[gentoo/funtoo.kits]: https://github.com/garybgenett/gary-os/blob/master/gentoo/funtoo.kits
[gentoo.config]: https://github.com/garybgenett/gary-os/blob/master/gentoo.config
[gentoo/.emergent]: https://github.com/garybgenett/gary-os/blob/master/gentoo/.emergent
[dwm]: https://github.com/garybgenett/gary-os/blob/master/gentoo/savedconfig/x11-wm/dwm
[gentoo/sets/gary-os]: https://github.com/garybgenett/gary-os/blob/master/gentoo/sets/gary-os
[gentoo/sets/\_gary-os]: https://github.com/garybgenett/gary-os/blob/master/gentoo/sets/_gary-os

[gkrellaclock]: https://github.com/garybgenett/gary-os/blob/master/gentoo/_overlay/x11-plugins/gkrellaclock
[xclock\_size\_hack.patch]: https://github.com/garybgenett/gary-os/blob/master/gentoo/_overlay/x11-plugins/gkrellaclock/files/xclock_size_hack.patch

### Tools ######################################################################
[Tools]: #tools

This is a list of the primary tools and sites which are used to build and
distribute GaryOS.  Additional honorable mentions are in [Ecosystem].

First and foremost, the projects which brought opensource into the mainstream
need to be recognized:

  * GNU (GNU's Not Unix): [https://gnu.org](https://gnu.org)
  * GNU/Linux: [https://gnu.org/gnu/linux-and-gnu.html](https://gnu.org/gnu/linux-and-gnu.html)
  * Linux: [https://linuxfoundation.org](https://linuxfoundation.org), [https://kernel.org](https://kernel.org)

All the real heavy-lifting is accomplished using these tools/projects:

  * Funtoo: [https://funtoo.org](https://funtoo.org)
  * Gentoo: [https://gentoo.org](https://gentoo.org)
  * Linux initramfs: [https://kernel.org/doc/Documentation/filesystems/ramfs-rootfs-initramfs.txt](https://kernel.org/doc/Documentation/filesystems/ramfs-rootfs-initramfs.txt)
  * Grub: [https://gnu.org/software/grub](https://gnu.org/software/grub)

Kernel configuration, package lists and acknowledgments to:

  * Grml: [https://grml.org](https://grml.org)
  * SystemRescueCd: [http://www.system-rescue-cd.org](http://www.system-rescue-cd.org)

Special thanks to the sites which made worldwide distribution possible:

  * SourceForge: [https://sourceforge.net](https://sourceforge.net)
  * GitHub: [https://github.com](https://github.com)

GitHub was instrumental in inspiring the author to publish this project, but
SourceForge provided the distribution platform which made it possible to reach
an international audience overnight.

### Ecosystem ##################################################################
[Ecosystem]: #ecosystem

Beyond the [Tools] used to create and publish GaryOS, there is a small universe
of projects that either provided inspiration, see some use within GaryOS, or
are related projects that need to be pointed out.

To start, homage must be paid to those who started it all (at least, these are
the ones which the author used most over the years, after discovering tomsrtbt
in 1998):

  * tomsrtbt: [http://www.toms.net/rb](http://www.toms.net/rb)
  * KNOPPIX: [https://knopper.net/knoppix](https://knopper.net/knoppix)
  * Debian Live: [https://debian.org/devel/debian-live](https://debian.org/devel/debian-live)

Inspiration was provided by:

  * Metro: [https://funtoo.org/Metro_Quick_Start_Tutorial](https://funtoo.org/Metro_Quick_Start_Tutorial)
  * Buildroot: [https://buildroot.org](https://buildroot.org)
  * BusyBox: [https://busybox.net](https://busybox.net)
  * StaticPerl: [http://software.schmorp.de/pkg/App-Staticperl.html](http://software.schmorp.de/pkg/App-Staticperl.html)

There are also a few projects which are relied on for critical tasks or highly
visible components, and deserve mention:

  * Vim: [https://www.vim.org](https://www.vim.org)
  * Qemu: [https://qemu.org](https://qemu.org)
  * Suckless: [https://suckless.org](https://suckless.org)
  * Links: [http://links.twibright.com](http://links.twibright.com)

[Qemu]: https://qemu.org
[Suckless]: https://suckless.org
[Links]: http://links.twibright.com

It should be noted, with additional emphasis, the critical role tomsrtbt played
in the course of the author's career, and his sustained mentality towards the
malleability of GNU/Linux and its power and flexibility as a "run anywhere,
anyhow" computing environment.

********************************************************************************

# Instructions #################################################################
[Instructions]: #instructions

Below are the primary use cases considered for GaryOS.  Each is tested
every release, and contains validation information.

These are also considered the "howto" instructions for each case.

## Booting #####################################################################
[Booting]: #booting

### USB Drive & Grub Rescue ####################################################
[USB Drive & Grub Rescue]: #usb-drive--grub-rescue

  * Definition:
    * Boot into a mostly complete Grub environment directly from the
      boot record without requiring any additional files from disk.
    * Create a Grub "core.img" which can be booted using identical
      methods and options as GaryOS, such as PXE, Qemu, etc.
  * Last tested with:
    * Tested in place of GaryOS with both Qemu and PXE.
        * For details on PXE, see the [PXE Boot] section below.
    * Grub: sys-boot/grub-2.02_beta2-r3
  * Research and development:
    * [https://gnu.org/software/grub/manual/grub.html#BIOS-installation](https://gnu.org/software/grub/manual/grub.html#BIOS-installation)
        * [https://gnu.org/software/grub/manual/grub.html#Images](https://gnu.org/software/grub/manual/grub.html#Images)
    * [http://lukeluo.blogspot.com/2013/06/grub-how-to-4-memdisk-and-loopback.html](http://lukeluo.blogspot.com/2013/06/grub-how-to-4-memdisk-and-loopback.html)
    * [http://wiki.osdev.org/GRUB_2#Disk_image_instructions](http://wiki.osdev.org/GRUB_2#Disk_image_instructions)

For convenience and supportability, this case has also been automated in
the `grub.sh` script.  The `gary-os.grub.*` file in the root download
directory contains an archive of the output of this script.  However,
for this case the script will need to be run locally.  The [Windows
Dual-Boot] section above has more details on the `grub.sh` script and
its usage and output.

Instructions for Grub "rescue" image installation to hard disk:

  1. Create an empty working directory:
     * e.g. `mkdir /tmp/grub`
  2. Change into the working directory:
     * e.g. `cd /tmp/grub`
  3. Run the `grub.sh` script with a block device argument:
     * e.g. `grub.sh /dev/sda`
  4. The script will create necessary files in the working directory,
     and then uses `grub-bios-setup` to install the custom-built
     "core.img" into the boot record.
  5. The block device can now be booted directly into a Grub environment
     which does not require any access to disk for its modules or
     configuration.
     * **The working directory is no longer needed and can be deleted.**
  6. To remove, simply re-install Grub using `grub-install` as usual, or
     install another bootloader.

### Windows Dual-Boot ##########################################################
[Windows Dual-Boot]: #windows-dual-boot

  * Definition:
    * Boot using the native Windows bootloader.
    * No modifications to the hard drive partitions or boot records.
    * Do not require any files outside of `C:` in the Windows
      installation.
  * Last tested with:
    * GaryOS v3.0
    * MBR/GPT only; EFI not built or tested
    * Windows 7 Ultimate SP1 64-bit
    * Grub: sys-boot/grub-2.02_beta2-r3
  * Research and development:
    * [http://lists.gnu.org/archive/html/help-grub/2013-08/msg00005.html](http://lists.gnu.org/archive/html/help-grub/2013-08/msg00005.html)
        * [http://blog.mudy.info/2010/08/boot-grub2-stage2-directly-from-windows-bootmgr-with-grub4dos-stage1](http://blog.mudy.info/2010/08/boot-grub2-stage2-directly-from-windows-bootmgr-with-grub4dos-stage1)
    * [https://wiki.archlinux.org/index.php/Windows_and_Arch_Dual_Boot#Using_Windows_boot_loader](https://wiki.archlinux.org/index.php/Windows_and_Arch_Dual_Boot#Using_Windows_boot_loader)
        * [http://iceflatline.com/2009/09/how-to-dual-boot-windows-7-and-linux-using-bcdedit](http://iceflatline.com/2009/09/how-to-dual-boot-windows-7-and-linux-using-bcdedit)

For convenience and supportability, this case has been mostly automated
in the `grub.sh` script.  The `gary-os.grub.*` file in the root download
directory contains an archive of the output of this script.

Overview of the script:

  * When run without arguments, it creates a series of Grub images and
    configuration files in the current directory.
  * When run with a single block device argument, the target device will
    be used for installation of the "rescue" Grub image, rather than the
    example disk image file.

Overview of the output:

  * `bcdedit.bat`
    * Used to install/remove the necessary entries from the Windows
      bootloader database.
  * `bootstrap.*`
    * Grub "core.img" and configuration loaded from the Windows
      bootloader.  Uses the directory added to `C:` (instructions below)
      for modules (such as `i386-pc` directory) and menu configuration.
  * `grub.cfg`
    * Grub menu used by "bootstrap" above.  Can be modified as needed to
      boot other OSes/objects.
  * `rescue.*`
    * Grub "core.img" rescue environment detailed further in [Grub
      Rescue] section below.
  * `rescue_example.raw`
    * Hard disk image file example of installation of Grub "rescue"
      environment.

Instructions for Windows bootloader dual-boot:

  1. The script assumes a default installation, with a small boot
     partition as partition 1 and Windows `C:` on partition 2.  All
     other partitions must be 3 or higher.  Configurations that do not
     match this will require minor edits to the script, and a fresh
     build of the output directory.
  2. Copy the output directory to `C:\gary-os.grub`, or wherever the
     script has been modified to point to.
  3. Run the `bcdedit.bat` script as Administrator.  Running this script
     without Administrator privileges can cause unexpected and/or
     undesired results.  The `bcdedit.guid.txt` file that is created is
     necessary for automatic removal of the created boot entry.
  4. Place the GaryOS files at these locations:
     * `C:\gary-os-64.kernel`
     * `C:\gary-os-32.kernel`
  5. Use the new option in the Windows bootloader to switch to Grub and
     boot GaryOS (or other OSes/objects bootable by Grub).  Doing
     nothing will boot into Windows as usual.
  6. Simply update the GaryOS files in-place to upgrade.
  7. Run the `bcdedit.bat` script as Administrator to remove from the
     Windows bootloader configuration.  The directory and files created
     in `C:` need to be removed manually.

If the `bcdedit.guid.txt` file is lost, or otherwise becomes out of
date with the bootloader database, use the `bcdedit` command as
Administrator to remove the unwanted entries:

  1. Run `cmd` as Administrator.
  2. Run `bcdedit` to view the bootloader database.  Copy the
     `identifier` field for each GaryOS entry.
  3. Run `bcdedit /delete {identifier} /cleanup` for each entry.  Note
     that the `{identifier}` should be replaced with the full string
     output in #2 above, including the `{}` markers.
     * e.g. `bcdedit /delete {02a0fce9-68f5-11e3-aa07-e94d28b95f82}
       /cleanup`

### PXE Boot ###################################################################
[PXE Boot]: #pxe-boot

  * Definition:
    * Boot from a PXE environment.
    * With some modification of the Funtoo configuration and package list, this
      Metro automation can be used to create a lab workstation or other
      automated environment where a reboot completely resets each machine
      involved.
  * Last tested with:
    * GaryOS v3.0
    * DHCPd: net-misc/dhcp-4.2.5_p1-r2
    * TFTPd: net-misc/iputils-20121221-r2
    * iPXE: sys-firmware/ipxe-1.0.0_p20130624-r2
  * Research and development:
    * [https://wiki.archlinux.org/index.php/archboot#PXE_booting_.2F_Rescue_system](https://wiki.archlinux.org/index.php/archboot#PXE_booting_.2F_Rescue_system)

Once you have a functioning PXE environment, on a global or per-host
basis add the following configuration option to `dhcpd.conf`:

  * `filename "gary-os-[...].kernel";`

## Running #####################################################################
[Running]: #running

### Forensics & Recovery #######################################################
[Forensics & Recovery]: #forensics--recovery

  * Definition:
    * Boot into a completely "clean" environment, so that diagnostics
      and/or recovery can be done in a read-only manner.
  * Last tested with:
    * GaryOS v3.0

GaryOS is in a forensics mode by default.  Hardware scanning is
performed, but the hard drives are not mounted or otherwise touched.
All entries in `/etc/fstab` have been commented out.  As a result, swap
is also disabled.

Linux kernel options can further be used to disable hardware scanning
and interrogation.

It is a stated goal that forensics mode continue being the default.

### Networking Configuration ###################################################
[Networking Configuration]: #networking-configuration

  * Definition:
    * Configure networking, either wired or wireless
  * Last tested with:
    * GaryOS v3.0

No networking configuration or daemons are run by default, but several
networking packages are installed to ease on-the-fly setup.

For simple DHCP, the `dhcpcd` command can be run directly on the desired
interface, such as an Ethernet connection:

  * `dhcpcd eth0`

A more formal way of doing this would be to use the OpenRC scripts:

  * `rc-update add dhcpcd default ; rc`

For wireless networking, the NetworkManager package is available to
simplify the configuration:

  * `rc-update add NetworkManager default ; rc`

Wireless networks can then be scanned and configured:

  * e.g. ...

    ```
    nmcli device wifi rescan
    nmcli device wifi list
    nmcli device wifi connect [ssid] password [password]
    nmcli device status
    ```

The Funtoo OpenRC scripts have all sorts of advanced networking features
and options, covered in depth:
[http://funtoo.org/Networking](http://funtoo.org/Networking)

### Graphical Interface ########################################################
[Graphical Interface]: #graphical-interface

  * Definition:
    * Start up and use the X.Org GUI environment
  * Last tested with:
    * GaryOS v3.0

GaryOS boots to CLI (Command-Line Interface) by default.  To enter the
graphical interface, run `startx`.

The Linux kernel includes driver modules for many common video cards,
but to keep the size of GaryOS down the X.Org installation only includes
the VESA driver (which almost all modern video cards support).  If the
kernel driver for a video card is loaded at boot, it will prevent X.Org
from taking over.  If you plan to run the graphical interface, use the
`nomodeset` kernel option when booting to prevent Linux from loading any
video card drivers.

By default, the DWM window manager is used.  URxvt is the default
terminal emulator, and Surf is the default browser.  Both are wrapped
using the Tabbed utility.

Keyboard shortcuts:

  * Use `ALT-SHIFT-ENTER` to launch terminal emulator.
  * Use `ALT-CTRL-ENTER` to launch web browser.

More information:

  * Read `man dwm` for help on the window manager.
  * Read `man tabbed` for help on the tabbing utility.
  * Read `man urxvt` for help on the terminal emulator.
  * Read `man surf` for help on the web browser.

Thanks to the [Suckless](http://suckless.org) team for creating such
lightweight and useful software.

## Building ####################################################################
[Building]: #building

### Live Update ################################################################
[Live Update]: #live-update

  * Definition:
    * Update/install packages using Funtoo tools.
  * Last tested with:
    * GaryOS v3.0, with 8GB memory

A complete Funtoo environment is available.  In order to install/update
packages, a couple of missing items need to be put into place.  A surprising
number of packages can be installed without filling up the in-memory
filesystem.

Instructions for setting up update/install of packages:

  1. Install "portage" tree.
     * **Option 1:** Synchronize tree as usual.
         * `emerge --sync`
     * **Option 2:** Download `portage-*` archive from one of the `v#.#`
       version download directories; preferably from the one which
       matches your version of GaryOS.  This option is best if you plan
       to keep this file on the same media along side the GaryOS kernel
       file(s).  To extract:
         * `tar -pvvxJ -C /usr -f portage-[...].tar.xz`
     * Generally speaking, "Option 1" is a smaller/faster download than
       "Option 2".  However, "Option 2" has the benefit of offline
       access, and may be simpler to update from since it is at the same
       revision of the tree that was used to build that version of
       GaryOS.
  2. Perform minor hacks to get working in a RAMdisk environment.  These
     should **NOT** be done if planning to install to disk per the
     [Installation] section below.  They essentially disable available
     space checks, since the "portage" scripts expect to be using
     a physical disk.  Commands to run:
     * ...

        ```
        sed -i "s%has_space = False%has_space = True%g" \
            /usr/lib/portage/pym/portage/package/ebuild/fetch.py
        ```
     * `alias emerge="I_KNOW_WHAT_I_AM_DOING=true emerge"`
         * For details, see `"There is NOT at least"` in
           `/usr/portage/eclass/check-reqs.eclass`
  3. Make desired edits to `/etc/portage` configuration.
     * In particular, to complete configuration of the X.Org GUI the
       `INPUT_DEVICES` and `VIDEO_CARDS` variables should be properly
       configured.
     * Starting with `bindist`, there is a list of negated `-*` options
       at the end of the `USE` list which are necessary to build GaryOS
       via Metro.  All of these can/should be removed to get the full
       non-Metro configuration.
  4. Use all "portage" commands as usual.
     * e.g. `emerge firefox`

### Hard Drive Install #########################################################
[Hard Drive Install]: #hard-drive-install

  * Definition:
    * Install GaryOS to disk as a "stage3" build.
  * Last tested with:
    * GaryOS v3.0

The in-memory environment is a complete Funtoo installation, as shown in the
[Live Update] section above.  It can be copied directly to a new disk/partition
and booted as a fresh installation.

Instructions for installing to disk:

  1. Mount formatted disk/partition.
     * e.g. `mke2fs -t ext4 -jv /dev/sda2`
     * e.g. `mount /dev/sda2 /mnt`
  2. If you wish for `/boot` to be on a separate partition, mount that
     location in the target.
     * e.g. `mkdir /mnt/boot`
     * e.g. `mount /dev/sda1 /mnt/boot`
  3. Copy in-memory filesystem to installation target.
     * e.g. ...

        ```
        rsync -avv \
            --filter=-_/dev/** \
            --filter=-_/mnt/** \
            --filter=-_/proc/** \
            --filter=-_/run/** \
            --filter=-_/sys/** \
            / /mnt
        ```
  4. Add necessary partition information to `/etc/fstab`, remembering an
     entry for `/boot` if using a separate partition from #2 above.
     * e.g. `vi /mnt/etc/fstab`
  5. Update and install Grub, to make the new installation bootable.
     * e.g. `for FILE in dev proc sys ; do mount --bind /${FILE} /mnt/${FILE} ; done`
     * e.g. `chroot /mnt grub-install /dev/sda`
     * e.g. `chroot /mnt boot-update`
  6. Reboot into new installation, update `/etc/portage` configuration,
     install "portage" tree and update/install packages as desired.
  7. **Don't forget to change `hostname` and update `root` password!**

********************************************************************************
# Version History ##############################################################
[Version History]: #version-history

[64-bit]: http://sourceforge.net/projects/gary-os/files/gary-os-generic_64-funtoo-stable-v3.0.kernel
[32-bit]: http://sourceforge.net/projects/gary-os/files/gary-os-generic_32-funtoo-stable-v3.0.kernel
[Packages]: https://github.com/garybgenett/gary-os/blob/v3.0/_packages.64
[Notes]: #2015-03-16-v30-21811b59a8484b2a6b73e0c5277f23c50a0141dc0

## 2015-03-16 v3.0 21811b59a8484b2a6b73e0c5277f23c50a0141dc.0 ##################
[2015-03-16 v3.0 21811b59a8484b2a6b73e0c5277f23c50a0141dc.0]: #2015-03-16-v30-21811b59a8484b2a6b73e0c5277f23c50a0141dc0
[v3.0]: #2015-03-16-v30-21811b59a8484b2a6b73e0c5277f23c50a0141dc0

  * Files
    * 64-bit kernel: [gary-os-generic_64-funtoo-stable-v3.0.kernel](https://sourceforge.net/projects/gary-os/files/gary-os-generic_64-funtoo-stable-v3.0.kernel)
    * 32-bit kernel: [gary-os-generic_32-funtoo-stable-v3.0.kernel](https://sourceforge.net/projects/gary-os/files/gary-os-generic_32-funtoo-stable-v3.0.kernel)
    * Grub: [grub.sh](https://github.com/garybgenett/gary-os/blob/v3.0/scripts/grub.sh)
    * 64-bit packages: [https://github.com/garybgenett/gary-os/blob/v3.0/_packages.64](https://github.com/garybgenett/gary-os/blob/v3.0/_packages.64)
    * 32-bit packages: [https://github.com/garybgenett/gary-os/blob/v3.0/_packages.32](https://github.com/garybgenett/gary-os/blob/v3.0/_packages.32)
    * Readme: [https://github.com/garybgenett/gary-os/blob/v3.0/README.md](https://github.com/garybgenett/gary-os/blob/v3.0/README.md)
    * Source Stage3: [stage3-core2_64-funtoo-stable-2015-01-27.tar.xz](https://sourceforge.net/projects/gary-os/files/v3.0/stage3-core2_64-funtoo-stable-2015-01-27.tar.xz)
    * Source Portage: [portage-21811b59a8484b2a6b73e0c5277f23c50a0141dc.0.tar.xz](https://sourceforge.net/projects/gary-os/files/v3.0/portage-21811b59a8484b2a6b73e0c5277f23c50a0141dc.0.tar.xz)
  * Metro/Grub scripts
    * Release checklist in Metro script
    * General updates for upstream Metro changes/enhancements
    * Minor configuration updates for LVM, Postfix and Vim
    * Date variables for Funtoo/Grml upstream files/images
    * Warnings for non-matching upstream files/images
    * Miscellaneous syntax clean-up
    * Additional debugging option in Grub script
    * Updated list of Grub rescue modules
    * Grub rescue options variable
  * Funtoo configuration
    * Updated to new Portage commit
    * Minor improvements to audit/review scripting
    * Fixed `USE` variable, enabling Udev globally
    * Added additional input drivers, for touch devices
    * Added helper packages for networking and basic X.Org GUI scripting

## 2014-06-19 v2.0 873ca4a3a4e6ff41e510dbcf2e0fe549fb23474d.0 ##################
[2014-06-19 v2.0 873ca4a3a4e6ff41e510dbcf2e0fe549fb23474d.0]: #2014-06-19-v20-873ca4a3a4e6ff41e510dbcf2e0fe549fb23474d0
[v2.0]: #2014-06-19-v20-873ca4a3a4e6ff41e510dbcf2e0fe549fb23474d0

  * Files
    * 64-bit kernel: [gary-os-generic_64-funtoo-stable-v2.0.kernel](https://sourceforge.net/projects/gary-os/files/gary-os-generic_64-funtoo-stable-v2.0.kernel)
    * 32-bit kernel: [gary-os-generic_32-funtoo-stable-v2.0.kernel](https://sourceforge.net/projects/gary-os/files/gary-os-generic_32-funtoo-stable-v2.0.kernel)
    * Grub: [grub.sh](https://github.com/garybgenett/gary-os/blob/v2.0/scripts/grub.sh)
    * 64-bit packages: [https://github.com/garybgenett/gary-os/blob/v2.0/_packages.64](https://github.com/garybgenett/gary-os/blob/v2.0/_packages.64)
    * 32-bit packages: [https://github.com/garybgenett/gary-os/blob/v2.0/_packages.32](https://github.com/garybgenett/gary-os/blob/v2.0/_packages.32)
    * Readme: [https://github.com/garybgenett/gary-os/blob/v2.0/README.md](https://github.com/garybgenett/gary-os/blob/v2.0/README.md)
    * Source Stage3: [stage3-core2_64-funtoo-stable-2014-01-13.tar.xz](https://sourceforge.net/projects/gary-os/files/v2.0/stage3-core2_64-funtoo-stable-2014-01-13.tar.xz)
    * Source Portage: [portage-873ca4a3a4e6ff41e510dbcf2e0fe549fb23474d.0.tar.xz](https://sourceforge.net/projects/gary-os/files/v2.0/portage-873ca4a3a4e6ff41e510dbcf2e0fe549fb23474d.0.tar.xz)
  * Metro/Grub scripts
    * Added creation of package list files
    * Added `METRO_DEBUG` variable, for testing
    * Improved customization of `LDFLAGS` and `USE` variables
    * Better exemption handling for packages which fail to build
    * Fixed initrd build, so that it is more generally useful/applicable
    * Added documentation repository to commit tracking
    * Included Git repository in root filesystem, for reference
    * Moved Git repository handling to dedicated "git-export" function
    * Renamed example Grub disk image to a better extension
  * Funtoo configuration
    * Updated to new Portage commit
    * Complete review/revamp of USE flags
    * Added `LDFLAGS` variable options specific to Metro
    * Cleaned up "\_overlay" directory
    * Improvements to audit/review scripting
    * Minor configuration updates/improvements
    * Localized failed package commenting to 32-bit
    * Revised package list, adding CLI (Command-Line Interface) helpers
      and X.Org GUI, while pruning packages that are not as generally
      useful or widely implemented
      * In particular, removed custom Perl modules, Funtoo
        developer/specialized packages, document processing utilities,
        virtualization tools and media software
      * Previously, the X.Org GUI was a specific non-goal of the
        project.  However, certain extremely useful packages (such as
        Wireshark) required it.  The additional screen real-estate is
        also useful for management of multiple terminals and
        web-browsing for solutions to issues.  In order to meet these
        needs, it was decided to incorporate X.Org GUI packages with
        a minimal window manager footprint.
      * CLI interface remains the default (see [Minimal X.Org GUI]
        section for information on loading up and using the graphical
        environment).

## 2014-03-13 v1.1 95ad4fd257697618bae7402d4bc3a27499035d30.4 ##################
[2014-03-13 v1.1 95ad4fd257697618bae7402d4bc3a27499035d30.4]: #2014-03-13-v11-95ad4fd257697618bae7402d4bc3a27499035d304
[v1.1]: #2014-03-13-v11-95ad4fd257697618bae7402d4bc3a27499035d304

  * Files
    * 64-bit kernel: [gary-os-generic_64-funtoo-stable-v1.1.kernel](https://sourceforge.net/projects/gary-os/files/gary-os-generic_64-funtoo-stable-v1.1.kernel)
    * 32-bit kernel: [gary-os-generic_32-funtoo-stable-v1.1.kernel](https://sourceforge.net/projects/gary-os/files/gary-os-generic_32-funtoo-stable-v1.1.kernel)
    * Grub: [grub.sh](https://github.com/garybgenett/gary-os/blob/v1.1/scripts/grub.sh)
    * Readme: [https://github.com/garybgenett/gary-os/blob/v1.1/README](https://github.com/garybgenett/gary-os/blob/v1.1/README)
    * Source Stage3: [stage3-core2_64-funtoo-stable-2014-01-13.tar.xz](https://sourceforge.net/projects/gary-os/files/v1.1/stage3-core2_64-funtoo-stable-2014-01-13.tar.xz)
    * Source Portage: [portage-95ad4fd257697618bae7402d4bc3a27499035d30.4.tar.xz](https://sourceforge.net/projects/gary-os/files/v1.1/portage-95ad4fd257697618bae7402d4bc3a27499035d30.4.tar.xz)
  * Metro/Grub scripts
    * Added Linux kernel configurations from Grml, to provide more
      comprehensive and flexible hardware/feature support
    * Created Grub script, for rescue and dual-boot
    * Syntax and formatting clean-up
  * Funtoo configuration
    * Miscellaneous package changes

## 2014-02-28 v1.0 95ad4fd257697618bae7402d4bc3a27499035d30.3 ##################
[2014-02-28 v1.0 95ad4fd257697618bae7402d4bc3a27499035d30.3]: #2014-02-28-v10-95ad4fd257697618bae7402d4bc3a27499035d303
[v1.0]: #2014-02-28-v10-95ad4fd257697618bae7402d4bc3a27499035d303

  * Files
    * 64-bit kernel: [gary-os-generic_64-funtoo-stable-v1.0.kernel](https://sourceforge.net/projects/gary-os/files/gary-os-generic_64-funtoo-stable-v1.0.kernel)
    * 32-bit kernel: [gary-os-generic_32-funtoo-stable-v1.0.kernel](https://sourceforge.net/projects/gary-os/files/gary-os-generic_32-funtoo-stable-v1.0.kernel)
    * Readme: [https://github.com/garybgenett/gary-os/blob/v1.0/README](https://github.com/garybgenett/gary-os/blob/v1.0/README)
    * Source Stage3: [stage3-core2_64-funtoo-stable-2014-01-13.tar.xz](https://sourceforge.net/projects/gary-os/files/v1.0/stage3-core2_64-funtoo-stable-2014-01-13.tar.xz)
    * Source Portage: [portage-95ad4fd257697618bae7402d4bc3a27499035d30.3.tar.xz](https://sourceforge.net/projects/gary-os/files/v1.0/portage-95ad4fd257697618bae7402d4bc3a27499035d30.3.tar.xz)
  * Metro script
    * Completed support for both 64-bit and 32-bit builds
    * Switched to `generic` for all builds
    * Removed `-fomit-frame-pointer` GCC flag
    * Removed Grub customizations
    * Re-added `/boot` and `/var/db/pkg` directories, so the initramfs
      can be used as a "stage3" replacement
    * Added release/distribution processing
  * Funtoo configuration
    * Commented packages that broke during 32-bit build

## 2014-02-24 v0.3 95ad4fd257697618bae7402d4bc3a27499035d30.2 ##################
[2014-02-24 v0.3 95ad4fd257697618bae7402d4bc3a27499035d30.2]: #2014-02-24-v03-95ad4fd257697618bae7402d4bc3a27499035d302
[v0.3]: #2014-02-24-v03-95ad4fd257697618bae7402d4bc3a27499035d302

  * Files
    * 64-bit kernel: [gary-os-core2_64-funtoo-stable-v0.3.kernel](https://sourceforge.net/projects/gary-os/files/gary-os-core2_64-funtoo-stable-v0.3.kernel)
    * Source Stage3: [stage3-core2_64-funtoo-stable-2014-01-13.tar.xz](https://sourceforge.net/projects/gary-os/files/v0.3/stage3-core2_64-funtoo-stable-2014-01-13.tar.xz)
    * Source Portage: [portage-95ad4fd257697618bae7402d4bc3a27499035d30.2.tar.xz](https://sourceforge.net/projects/gary-os/files/v0.3/portage-95ad4fd257697618bae7402d4bc3a27499035d30.2.tar.xz)
  * Metro script
    * Consolidated kernel/initrd into single kernel/initramfs file
    * Added initial support for both 64-bit and 32-bit builds
  * Funtoo configuration
    * Updated build/installation script with code to expand Metro
      "stage3" files for testing package builds and fixing breaks
    * Customized package list and USE flags for Metro build, to reduce
      size of installation to below 500MB Linux kernel limit
    * Completely removed X, Java and TeX Live / LaTeX
    * Added sound and miscellaneous media packages

## 2014-02-13 v0.2 95ad4fd257697618bae7402d4bc3a27499035d30.1 ##################
[2014-02-13 v0.2 95ad4fd257697618bae7402d4bc3a27499035d30.1]: #2014-02-13-v02-95ad4fd257697618bae7402d4bc3a27499035d301
[v0.2]: #2014-02-13-v02-95ad4fd257697618bae7402d4bc3a27499035d301

  * Files
    * 64-bit kernel: [gary-os-core2_64-funtoo-stable-v0.2.kernel](https://sourceforge.net/projects/gary-os/files/gary-os-core2_64-funtoo-stable-v0.2.kernel)
    * 64-bit initrd: [gary-os-core2_64-funtoo-stable-v0.2.initrd](https://sourceforge.net/projects/gary-os/files/gary-os-core2_64-funtoo-stable-v0.2.initrd)
    * Source Stage3: [stage3-core2_64-funtoo-stable-2014-01-13.tar.xz](https://sourceforge.net/projects/gary-os/files/v0.2/stage3-core2_64-funtoo-stable-2014-01-13.tar.xz)
    * Source Portage: [portage-95ad4fd257697618bae7402d4bc3a27499035d30.1.tar.xz](https://sourceforge.net/projects/gary-os/files/v0.2/portage-95ad4fd257697618bae7402d4bc3a27499035d30.1.tar.xz)
  * Metro script
    * Added revision handling
  * Funtoo configuration
    * Added packages from Grml and SystemRescueCD package lists
    * Enabled `gpm` USE flag

## 2014-02-09 v0.1 95ad4fd257697618bae7402d4bc3a27499035d30.0 ##################
[2014-02-09 v0.1 95ad4fd257697618bae7402d4bc3a27499035d30.0]: #2014-02-09-v01-95ad4fd257697618bae7402d4bc3a27499035d300
[v0.1]: #2014-02-09-v01-95ad4fd257697618bae7402d4bc3a27499035d300

  * Files
    * 64-bit kernel: [gary-os-core2_64-funtoo-stable-v0.1.kernel](https://sourceforge.net/projects/gary-os/files/gary-os-core2_64-funtoo-stable-v0.1.kernel)
    * 32-bit initrd: [gary-os-core2_64-funtoo-stable-v0.1.initrd](https://sourceforge.net/projects/gary-os/files/gary-os-core2_64-funtoo-stable-v0.1.initrd)
    * Source Stage3: [stage3-core2_64-funtoo-stable-2014-01-13.tar.xz](https://sourceforge.net/projects/gary-os/files/v0.1/stage3-core2_64-funtoo-stable-2014-01-13.tar.xz)
    * Source Portage: [portage-95ad4fd257697618bae7402d4bc3a27499035d30.0.tar.xz](https://sourceforge.net/projects/gary-os/files/v0.1/portage-95ad4fd257697618bae7402d4bc3a27499035d30.0.tar.xz)
  * Metro script
    * Initial proof of concept, with separate kernel/initrd files
  * Funtoo configuration
    * Active personal configuration at time of build
    * Commented packages that broke

********************************************************************************
*End Of File*
