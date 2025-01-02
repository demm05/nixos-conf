{ username, ... }:
{
	wayland.windowManagaersettings.hyprland.settings = {
		env = {
			NIXOS_OZONE_WL = "1";
			NIXPKGS_ALLOW_UNFREE = "1";
			XDG_CURRENT_DESKTOP = "Hyprland";
			XDG_SESSION_TYPE = "wayland";
			XDG_SESSION_DESKTOP = "Hyprland";
			GDK_BACKEND = "wayland, x11";
			CLUTTER_BACKEND = "wayland";
			QT_QPA_PLATFORM = "wayland;xcb";
			QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
			QT_AUTO_SCREEN_SCALE_FACTOR = "1";
			SDL_VIDEODRIVER = "x11";
			MOZ_ENABLE_WAYLAND = "1";
		};

		exec-once = [
			"dbus-update-activation-environment --systemd --all"
			"systemctl --user import-environment QT_QPA_PLATFORMTHEME WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
			"killall -q swww;sleep .5 && swww init"
			"killall -q waybar;sleep .5 && waybar"
			"killall -q swaync;sleep .5 && swaync"
			"nm-applet --indicator"
			"lxqt-policykit-agent"
			"sleep 1.5 && swww img /home/${username}/Pictures/Wallpapers/beautifulmountainscape.jpg"
		];

		monitor = ",preferred,auto,1";
			# ${extraMonitorSettings}  # If you have this defined somewhere

		general = {
			gaps_in = 6;
			gaps_out = 8;
			border_size = 2;
			layout = "dwindle";
			resize_on_border = true;
			#	col = {
			#		active_border = "rgb(${config.stylix.base16Scheme.base08}) rgb(${config.stylix.base16Scheme.base0C}) 45deg";
			#		inactive_border = "rgb(${config.stylix.base16Scheme.base01})";
			#	};
		};

		input = {
			kb_layout = "us"; # Assuming you have this in your config
			kb_options = "grp:alt_shift_toggle";
			#kb_options = "caps:super";
			follow_mouse = 1;
				touchpad = {
				natural_scroll = true;
				disable_while_typing = true;
				scroll_factor = 0.8;
			};
			sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
			accel_profile = "flat";
		};

		windowrule = [
			"noborder,^(wofi)$"
			"center,^(wofi)$"
			"center,^(steam)$"
			"float, nm-connection-editor|blueman-manager"
			"float, swayimg|vlc|Viewnior|pavucontrol"
			"float, nwg-look|qt5ct|mpv"
			"float, zoom"
		];

		windowrulev2 = [
			"stayfocused, title:^()$,class:^(steam)$"
			"minsize 1 1, title:^()$,class:^(steam)$"
			"opacity 0.9 0.7, class:^(Brave)$"
			"opacity 0.9 0.7, class:^(thunar)$"
		];

		gestures = {
			workspace_swipe = true;
			workspace_swipe_fingers = 3;
		};

		misc = {
			initial_workspace_tracking = 0;
			mouse_move_enables_dpms = true;
			key_press_enables_dpms = false;
		};

		animations = {
			enabled = "yes";
				bezier = {
				wind = "0.05, 0.9, 0.1, 1.05";
				winIn = "0.1, 1.1, 0.1, 1.1";
				winOut = "0.3, -0.3, 0, 1";
				liner = "1, 1, 1, 1";
			};

			animation = {
				windows = "1, 6, wind, slide";
				windowsIn = "1, 6, winIn, slide";
				windowsOut = "1, 5, winOut, slide";
				windowsMove = "1, 5, wind, slide";
				border = "1, 1, liner";
				fade = "1, 10, default";
				workspaces = "1, 5, wind";
			};
		};

		decoration = {
			rounding = 10;
			drop_shadow = true;
			shadow_range = 4;
			shadow_render_power = 3;
			col.shadow = "rgba(1a1a1aee)";
			blur = {
				enabled = true;
				size = 5;
				passes = 3;
				new_optimizations = "on";
				ignore_opacity = "off";
			};
		};

			# plugin = { 
			#   hyprtrails = { }; 
			# }; 

		dwindle = {
			pseudotile = true;
			preserve_split = true;
		};
	};
}
