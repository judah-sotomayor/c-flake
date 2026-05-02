{ stdenv
, fetchFromGitHub
, sbcl 
}:

sbcl.pkgs.qlot-cli.overrideLispAttrs ( old: rec {
  pname = "qlot";
  version = "1.8.3";
  src = fetchFromGitHub {
    owner = "fukamachi";
    repo = "qlot";
    rev = "1.8.3";
    hash = "sha256-jK80A9fp30UnXgHkHFSDIZdG9VH4mNL2OiN8oENt74Q=";
  };

  QLOT_HOME = "/usr/local/lib/qlot";
  QLOT_CACHE_DIRECTORY = if stdenv.isDarwin then "/Library/Caches/qlot" else "/var/cache/qlot";

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp qlot.asd $out
    rm *.asd
    cp -r * $out

    mv $out/qlot $out/bin
    wrapProgram $out/bin/qlot \
        --set QLOT_CACHE_DIRECTORY $QLOT_CACHE_DIRECTORY \
        --prefix LD_LIBRARY_PATH : $LD_LIBRARY_PATH

    runHook postInstall
  '';
})
