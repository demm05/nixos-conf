{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    clang
    clang-tools
    gnumake
    cmake
    bear
    gdb
    gcc
    cppcheck
    valgrind
    readline
    criterion
  ];
}
