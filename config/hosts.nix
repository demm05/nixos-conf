let
	users = import ./users.nix;
in
{
	workstation = {
		hostname = "laptop";
		dir = "laptop";
	    arch = "x86_64-linux";
	    user = users.default;
	};
}
