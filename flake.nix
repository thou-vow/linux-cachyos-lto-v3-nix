{
  description = "Cached linux_cachyos-lto-v3";

  nixConfig = {
    extra-substituters = [
      "https://thou-vow-linux.cachix.org"
      "https://nyx-cache.chaotic.cx/"
    ];
    extra-trusted-public-keys = [
      "thou-vow-linux.cachix.org-1:DdL3Lv29JWukrCFnGJrWnfoWMcU3sQ0Js8C1ubd7bXE="
      "nyx-cache.chaotic.cx:dJxTrgMC3V3cFfyIiBQDQorG6k1LsqurH/srpMSq7qk="
    ];
  };

  inputs = {
    chaotic-nyx = {
      url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
      inputs = {
        flake-schemas.follows = "";
        home-manager.follows = "";
      };
    };
    nixpkgs.follows = "chaotic-nyx/nixpkgs";
  };

  outputs = inputs: {
    packages.x86_64-linux.linux_cachyos-lto-v3 =
      (inputs.chaotic-nyx.legacyPackages.x86_64-linux.linuxPackages_cachyos-lto.cachyOverride {
        cachyVars =
          inputs.chaotic-nyx.legacyPackages.x86_64-linux.linuxPackages_cachyos-lto.kernel.cachyConfig.cachyVars
          // {
            _processor_opt = "GENERIC_V3";
          };
      }).kernel;
  };
}
