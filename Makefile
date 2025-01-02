rebuild:
	sudo nixos-rebuild switch --flake .#laptop
	
test:
	sudo nixos-rebuild test --flake .#laptop

build:
	nixos-rebuild build --flake .#laptop

update:
	home-manager switch --flake .#laptop

clean:
	nix-collect-garbage -d

.PHONY: update clean rebuild
