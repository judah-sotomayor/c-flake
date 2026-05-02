{ stdenv
, fetchFromGitHub
, gcc
, curl
, pkg-config
, check
, gnutls
, jansson
, libmicrohttpd
, orcania
, yder
, zlib
}:


stdenv.mkDerivation {
  name = "ulfius";
  version = "2.7.15";

  src = fetchFromGitHub {
    owner = "babelouest";
    repo = "ulfius";
    rev = "v2.7.15";
    hash = "sha256-YvMhcobvTEm4LxhNxi1MJX8N7VAB3YOvp+LxioJrKHU=";
  };

  outputs = ["out"];
  nativeBuildInputs = [
    gcc
  ];
  
  buildInputs = [
    curl
    pkg-config
    check
  ];
  propagatedBuildInputs = [
    gnutls
    jansson
    libmicrohttpd
    orcania
    yder
    zlib
  ];

  installPhase = ''
    mkdir -p $out/lib
              make DESTDIR=$out install;
  '';
  checkPhase = "make check";
}  
