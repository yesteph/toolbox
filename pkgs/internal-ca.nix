{ stdenv
, source
, runCommand
, makeWrapper
, gopass
, cfssl
, kubectl
}:

stdenv.mkDerivation rec {
  pname = "internal-ca";
  version = "0.1";
  src = source.outPath;

  buildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin
    cp internal-ca $out/bin/
    chmod +x $out/bin/internal-ca
    wrapProgram $out/bin/internal-ca --prefix PATH ":" ${gopass}/bin:${cfssl}/bin:${kubectl}/bin
  '';

  meta = with stdenv.lib; {
    description = "Tools to provision CAs in cert-manager.";
    homepage = "https://github.com/Caascad/internal-ca";
    license = licenses.mit;
    maintainers = with maintainers; [ eonpatapon ];
  };

}
