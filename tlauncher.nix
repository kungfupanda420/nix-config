{ stdenvNoCC, fetchurl, makeWrapper, jre }:

stdenvNoCC.mkDerivation rec {
  pname = "tlauncher";
  version = "2.86"; # Replace with actual version

  src = fetchurl {
    url = "file:///path/to/your/tlauncher.jar"; # Or use a direct URL
    # If downloading from web:
    # url = "https://tlauncher.org/jar";
    sha256 = "096q2zqr1zbhkcrfz73pf71x0z1kp4a5bq7yv3rijd9za6mz0dm6"; # Replace with actual hash
  };

  nativeBuildInputs = [ makeWrapper ];

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin $out/share/java
    cp $src $out/share/java/tlauncher.jar
    
    makeWrapper ${jre}/bin/java $out/bin/tlauncher \
      --add-flags "-jar $out/share/java/tlauncher.jar"
  '';

  meta = with stdenvNoCC.lib; {
    description = "TLauncher Minecraft client";
    homepage = "https://tlauncher.org/";
    license = licenses.unfree;
    platforms = platforms.all;
  };
}
