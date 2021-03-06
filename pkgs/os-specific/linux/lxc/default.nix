{ stdenv, autoreconfHook, fetchurl, libcap, apparmor, perl, docbook2x
, docbook_xml_dtd_45, gnutls, pkgconfig
}:

stdenv.mkDerivation rec {
  name = "lxc-1.0.3";

  src = fetchurl {
    url = "http://github.com/lxc/lxc/archive/${name}.tar.gz";
    sha256 = "04k45jgj2i501yhm467s1a1yk7h7q0fjhspys158w1a2m1hari4z";
  };

  buildInputs = [ libcap apparmor perl docbook2x gnutls autoreconfHook pkgconfig ];

  patches = [ ./install-localstatedir-in-store.patch ./support-db2x.patch ];

  preConfigure = ''
    export XML_CATALOG_FILES=${docbook_xml_dtd_45}/xml/dtd/docbook/catalog.xml
    substituteInPlace doc/rootfs/Makefile.am --replace '@LXCROOTFSMOUNT@' '$out/lib/lxc/rootfs'
  '';

  configureFlags = [
    "--localstatedir=/var"
    "--with-rootfs-path=/var/lib/lxc/rootfs"
    "--enable-doc"
    "--enable-tests"
    "--enable-apparmor"
  ];

  meta = {
    homepage = "http://lxc.sourceforge.net";
    description = "userspace tools for Linux Containers, a lightweight virtualization system";
    license = stdenv.lib.licenses.lgpl21Plus;

    longDescription = ''
      LXC is the userspace control package for Linux Containers, a
      lightweight virtual system mechanism sometimes described as
      "chroot on steroids". LXC builds up from chroot to implement
      complete virtual systems, adding resource management and isolation
      mechanisms to Linux’s existing process management infrastructure.
    '';

    platforms = stdenv.lib.platforms.linux;
    maintainers = [ stdenv.lib.maintainers.simons ];
  };
}
