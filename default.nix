{ pkgs ? import <nixpkgs> { } }:
let
  china-dictatorship = pkgs.python3Packages.buildPythonPackage rec {
    pname = "china-dictatorship";
    version = "0.0.74";
    src = pkgs.fetchFromGitHub {
      owner = "cirosantilli";
      repo = "china-dictatorship";
      rev = "9bd1cb194fb4598b36148a063284c73ed2a5ba92";
      sha256 = "sha256-F9TF9nwvCWq5JSJ4fYrAbBwPRyaQpYvUKY2a+4Q0q74=";
    };
    nativeBuildInputs = [
      pkgs.asciidoctor
      pkgs.ruby
    ];
    patchPhase = ''
      # Fails to build properly
      asciidoctor README.adoc -D china_dictatorship
    '';
  };
  vcdvcd = pkgs.python3Packages.buildPythonPackage rec {
    pname = "vcdvcd";
    version = "2.3.3";
    src = pkgs.fetchFromGitHub {
      owner = "cirosantilli";
      repo = "vcdvcd";
      rev = "963e1c882705f8bd35224a20eed62951f6f18c13";
      sha256 = "sha256-nfsdKdxVJp1ob02zm6Z9gdXs6TfYs9oRRdwl4NCTlXY=";
    };
    propagatedBuildInputs = [
      china-dictatorship
    ];
  };
in
with pkgs;
python3Packages.buildPythonPackage rec {
  name = "vcd2wavedrom";
  version = "1.0.2";
  src = ./.;
  format = "other";

  propagatedBuildInputs = [
    vcdvcd
  ];

  buildPhase = ''
    
  '';

  installPhase = ''
    mkdir -p $out/bin/
    cp vcd2wavedrom/vcd2wavedrom.py $out/bin/vcd2wavedrom
    chmod a+x $out/bin/vcd2wavedrom
  '';


  meta = with lib; {
    description = "Transform a VCD file to wavedrom format";
    longDescription = ''
      Transform a VCD file to wavedrom format
    '';
    homepage = "https://github.com/Toroid-io/vcd2wavedrom";
    license = licenses.mit;
    platforms = lib.platforms.all;
    mainProgram = "vcd2wavedrom";
  };
}
