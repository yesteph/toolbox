{ stdenv
, makeWrapper
, coreutils
, jq
, utillinux
, gnused
}:

stdenv.mkDerivation {
  pname = "toolbox";
  version = "1.7.1";

  buildInputs = [ makeWrapper ];
  passAsFile = [ "buildCommand" ];
  buildCommand = ''
    mkdir -p $out/bin $out/share/bash-completion/completions
    cp ${./toolbox.sh} $out/bin/toolbox
    chmod +x $out/bin/toolbox
    bash $out/bin/toolbox completions >  $out/share/bash-completion/completions/toolbox

    wrapProgram $out/bin/toolbox --prefix PATH ":" ${coreutils}/bin:${jq}/bin:${utillinux}/bin:${gnused}/bin
  '';

  meta = with stdenv.lib; {
    description = "Caascad toolbox";
    homepage = "https://github.com/Caascad/toolbox";
    license = licenses.mit;
    maintainers = with maintainers; [ eonpatapon ];
  };

}
