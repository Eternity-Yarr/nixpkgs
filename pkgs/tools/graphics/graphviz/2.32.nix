{ stdenv, fetchurl, pkgconfig, libpng, libjpeg, expat, libXaw
, yacc, libtool, fontconfig, pango, gd, xlibs, gts, gettext, cairo
}:

stdenv.mkDerivation rec {
  version = "2.32.0";
  name = "graphviz-${version}";

  src = fetchurl {
    url = "http://www.graphviz.org/pub/graphviz/ARCHIVE/${name}.tar.gz";
    sha256 = "0ym7lw3xnkcgbk32vfmm3329xymca60gzn90rq6dv8887qqv4lyq";
  };

  buildInputs =
    [ pkgconfig libpng libjpeg expat libXaw yacc libtool fontconfig
      pango gd gts
    ] ++ stdenv.lib.optionals (xlibs != null) [ xlibs.xlibs xlibs.libXrender ]
    ++ stdenv.lib.optional (stdenv.system == "x86_64-darwin") gettext;

  CPPFLAGS = stdenv.lib.optionalString (stdenv.system == "x86_64-darwin") "-I${cairo}/include/cairo";

  configureFlags =
    [ "--with-pngincludedir=${libpng}/include"
      "--with-pnglibdir=${libpng}/lib"
      "--with-jpegincludedir=${libjpeg}/include"
      "--with-jpeglibdir=${libjpeg}/lib"
      "--with-expatincludedir=${expat}/include"
      "--with-expatlibdir=${expat}/lib"
      "--with-cgraph=no"
      "--with-sparse=no"
    ]
    ++ stdenv.lib.optional (xlibs == null) "--without-x";

  preBuild = ''
    sed -e 's@am__append_5 *=.*@am_append_5 =@' -i lib/gvc/Makefile
  '';

  # "command -v" is POSIX, "which" is not
  postInstall = ''
    sed -i 's|`which lefty`|"'$out'/bin/lefty"|' $out/bin/dotty
    sed -i 's|which|command -v|' $out/bin/vimdot
  '';

  meta = {
    homepage = "http://www.graphviz.org/";
    description = "Open source graph visualization software";

    longDescription = ''
      Graphviz is open source graph visualization software. Graph
      visualization is a way of representing structural information as
      diagrams of abstract graphs and networks. It has important
      applications in networking, bioinformatics, software engineering,
      database and web design, machine learning, and in visual
      interfaces for other technical domains.
    '';

    hydraPlatforms = stdenv.lib.platforms.linux ++ stdenv.lib.platforms.darwin;
    maintainers = with stdenv.lib.maintainers; [ simons bjornfor raskin ];
    inherit version;
  };
}
