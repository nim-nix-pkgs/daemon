{
  description = ''Cross-platform process daemonization library'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."daemon-master".dir   = "master";
  inputs."daemon-master".owner = "nim-nix-pkgs";
  inputs."daemon-master".ref   = "master";
  inputs."daemon-master".repo  = "daemon";
  inputs."daemon-master".type  = "github";
  inputs."daemon-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."daemon-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}