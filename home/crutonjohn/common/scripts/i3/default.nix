let
  i3lockscreen = let
    version = "1.0.0";
  in
    stdenv.mkDerivation {
      name = "i3lockscreen";
      src = ./i3lockscreen.sh
      installPhase = ''
        # Make the output directory
        mkdir -p $out/bin

        # Copy the script there and make it executable
        cp i3lockscreen.sh $out/bin/i3lockscreen
        chmod +x $out/bin/i3lockscreen
      '';
    };
  i3loadlayout = let
    version = "1.0.0";
  in
    stdenv.mkDerivation {
      name = "i3loadlayout";
      src = ./i3loadlayout.sh
      installPhase = ''
        # Make the output directory
        mkdir -p $out/bin

        # Copy the script there and make it executable
        cp i3loadlayout.sh $out/bin/i3loadlayout
        chmod +x $out/bin/i3loadlayout
      '';
    };
in

stdenv.mkDerivation {
  name = "i3lockscreen-environment";
  buildInputs = [ i3lockscreen ];
}
stdenv.mkDerivation {
  name = "i3loadlayout-environment";
  buildInputs = [ i3loadlayout ];
}