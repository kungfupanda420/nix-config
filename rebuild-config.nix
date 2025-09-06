{ pkgs, ... }:

{
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "rebuild" ''
      exec ${pkgs.python3}/bin/python ${./rebuild.py} "$@"
    '')
  ];
}
