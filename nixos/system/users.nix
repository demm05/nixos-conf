{ config, pkgs, ... }:

let
  users = import ../../../config/users.nix;

  ifGroupsExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
	security = {
		sudo = {
			wheelNeedsPassword = false;
		};
	};

	users.users.${users.default} = {
		isNormalUser = true;
		extraGroups =
			[ "wheel" ]
			++ ifGroupsExist [
			"docker"
			"networkmanager"
		];

		# Dynamically read all .pub files from the specified directory
		# openssh.authorizedKeys.keys = sshUtils.readPubKeys sshKeysDir;
	};
}
