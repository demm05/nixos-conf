{ inputs, pkgs, ... }:
{
	home.packages = with pkgs; [
		kitty pyprland wofi xfce.thunar 
	];
	wayland.windowManager.hyprland = {
	enable = true;
	settings = {
		# Your existing settings here, e.g.,
		"$mod" = "SUPER"; 
		"$terminal" = "kitty"; # Or your preferred terminal
		"$fileManager" = "thunar"; # Or your preferred file manager
		"$menu" = "wofi --show drun"; # Or your preferred menu

		bind = [
			"$mod, Q, exec, $terminal"
			"$mod, C, killactive"
			"$mod, M, exit"
			"$mod, E, exec, $fileManager"
			"$mod, V, togglefloating"
			"$mod, R, exec, $menu"
			"$mod, P, pseudo" # dwindle
			"$mod, J, togglesplit" # dwindle
			"$mod, F, exec, zen"

			# Move focus with mainMod + arrow keys
			"$mod, left, movefocus, l"
			"$mod, right, movefocus, r"
			"$mod, up, movefocus, u"
			"$mod, down, movefocus, d"

			# Switch workspaces with mainMod + [0-9]
			"$mod, 1, workspace, 1"
			"$mod, 2, workspace, 2"
			"$mod, 3, workspace, 3"
			"$mod, 4, workspace, 4"
			"$mod, 5, workspace, 5"
			"$mod, 6, workspace, 6"
			"$mod, 7, workspace, 7"
			"$mod, 8, workspace, 8"
			"$mod, 9, workspace, 9"
			"$mod, 0, workspace, 10"

			# Move active window to a workspace with mainMod + SHIFT + [0-9]
			"$mod SHIFT, 1, movetoworkspace, 1"
			"$mod SHIFT, 2, movetoworkspace, 2"
			"$mod SHIFT, 3, movetoworkspace, 3"
			"$mod SHIFT, 4, movetoworkspace, 4"
			"$mod SHIFT, 5, movetoworkspace, 5"
			"$mod SHIFT, 6, movetoworkspace, 6"
			"$mod SHIFT, 7, movetoworkspace, 7"
			"$mod SHIFT, 8, movetoworkspace, 8"
			"$mod SHIFT, 9, movetoworkspace, 9"
			"$mod SHIFT, 0, movetoworkspace, 10"

				#		# Example special workspace (scratchpad)
				#		"$mod, S, togglespecialworkspace, magic"
				#		"$mod SHIFT, S, movetoworkspace, special:magic"

				#		# Scroll through existing workspaces with mainMod + scroll
				#		"$mod, mouse_down, workspace, e+1"
				#		"$mod, mouse_up, workspace, e-1"

				#		# Move/resize windows with mainMod + LMB/RMB and dragging
				#		"$mod, mouse:272, movewindow"
				#		"$mod, mouse:273, resizewindow"

				#		# Laptop multimedia keys for volume and LCD brightness
				#		",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
				#		",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
				#		",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
				#		",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
				#		",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
				#		",XF86MonBrightnessDown, exec, brightnessctl s 10%-"

				#		# Requires playerctl
				#		", XF86AudioNext, exec, playerctl next"
				#		", XF86AudioPause, exec, playerctl play-pause"
				#		", XF86AudioPlay, exec, playerctl play-pause"
				#		", XF86AudioPrev, exec, playerctl previous"
		];
	};
	};
}
