{ config, lib, ... }:

{
	programs.waybar = {	
		enable = true;
		settings = {
			mainBar = {
				height = 30;
				spacing = 4;
				modules-left = ["sway/workspaces" "sway/,mode" "sway/scratchpad" "custom/media"];
				modules-center = ["sway/window"];
				modules-right = lib.mkIf (config.system.profile == "gabriel") [
          "pulseaudio" "network" "disk" "cpu" "memory" "temperature" "battery" "clock" "tray"
        ] ([
          "pulseaudio" "network" "disk" "cpu" "memory" "temperature" "clock" "tray"
        ]);

				"sway/window" = {
					format = "{title}";
					max-length = 100;
				};
				"sway/mode" = {
					format = "<span style=\"italic\">{}</span>";
				};
				"tray" = {
					spacing = 10;	
				};
				"clock" = {
        	tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
					format-alt = "{:%Y-%m-%d}";
    		};
    		"cpu" = {
        	format = "{usage}% ";
        	tooltip = true;
    		};
    		"memory" = {
        	format = "{}% ";
    		};
    		"temperature" = {
		    # thermal-zone = 2;
        # hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
        	critical-threshold = 80;
        # format-critical = "{temperatureC}°C {icon}";
        	format = "{temperatureC}°C {icon}";
        	format-icons = ["" "" ""];
    		};
				"disk" = {
					interval = 30;
					format = "{percentage_used}% ";
					format-alt = "{specific_free:0.2f}/{specific_total:0.2f}GiB";
					unit = "GiB";
					path = "/";
				};
				"battery" = {
					bat = "BAT0";
					interval = 60;
					states = {
						warning = 30;
						critical = 15;
					};
					format = "{capacity}% {icon}";
					format-icons = ["" "" "" "" ""];
					max-length = 25;
				};
				"network" = {
		    # interface = "wlp2*"; // (Optional) To force the use of this interface
					format-wifi = /*"{essid} ({signalStrength}%)*/"";
					format-ethernet = "";
					tooltip-format = "{ifname} via {gwaddr} ";
					format-linked = "{ifname} (No IP) ";
					format-disconnected = "⚠";
					format-alt = /*"{ifname}: */"{ipaddr}/{cidr}";
				};
				"pulseaudio" = {
		    # scroll-step = 1; // %, can be a float
					format = "{volume}% {icon}" /*{format_source}"*/;
					format-bluetooth = "{volume}% {icon}-"/* {format_source}"*/;
					format-bluetooth-muted = "muted {icon}-"/* {format_source}"*/;
					format-muted = "muted"/* {format_source}"*/;
					format-source = "{volume}% ";
					format-source-muted = "";
					format-icons = {
						headphone = "";
						hands-free = "";
						headset = "";
						phone = "";
						portable = "";
						car = "";
						default = ["" "" ""];
					};
					on-click = "pwvucontrol";
				};
			};
		};
		style = ''
	    * {
				border: 0;
				border-radius: 0;
				padding: 0 0;
				font-family: 'Fira Code';
				font-size: 13px;
				}

			window#waybar {
				color: #cad3f5;
				background:rgba (24, 25, 38, 0.7);
	    }
	
	    #workspaces button {
    		color: #cad3f5;
				margin-left: 0px;
    		margin-right: 0px;
    		padding: 0px 1px;
    		border-bottom: 2px;
	    }

	    #workspaces button.focused {
    		border-color: #397367;
    		font-weight: bold;
    		background-color: #b7bdf8;
    		color: #1e2030;
	    }

	    #workspaces button.focused:hover {
    		color: #b7bdf8;
	    }

	    #workspaces button:hover {
    		border-color: #397367;
				background: none;
    		box-shadow: inset 0 -3px #b7bdf8;
	    }

	    #workspaces button.focused:hover {
				background: rgba(0, 0, 0, 0.2);
	    }

	    #clock, #battery, #cpu, #memory,#idle_inhibitor, #temperature,#custom-keyboard-layout, #backlight, #network, #pulseaudio, #mode, #tray, #window,#custom-launcher,#custom-power,#custom-pacman,#disk {
    		padding: 0 3px;
    		border-bottom: 3px;
    		border-style: solid;
    		margin-right: 5px;
    		margin-left: 5px;
	    }
 
	    /* -----------------------------------------------------------------------------
 	    * Module styles
 	    * -------------------------------------------------------------------------- */

	    #disk {
    		color: #7dc4e4;
	    }

	    #clock {
				color: #c6a0f6;
	    }

	    #backlight {
    		color: #fb4934;
	    }

	    #battery {
    		color: #83a598;
	    }

	    #battery.charging {
    		color: #81a1c1;
	    }

	    @keyframes blink {
    		to {
					color: #4c566a;
        	background-color: #eceff4;
    		}
	    }

	    #battery.critical:not(.charging) {
    		background: #bf616a;
    		color: #eceff4;
    		animation-name: blink;
    		animation-duration: 0.5s;
    		animation-timing-function: linear;
    		animation-iteration-count: infinite;
    		animation-direction: alternate;
	    }

	    #cpu {
    		color: #f5a97f;
	    }

	    #memory {
    		color: #f0c6c6;
	    }

	    #network.disabled {
    		color: #bf616a;
	    }

	    #network {
    		color: #eed49f;
	    }

	    #network.disconnected {
    		color: #bf616a;
	    }

	    #pulseaudio {
    		color: #8aadf4;
	    }

	    #pulseaudio.muted {
	      color: #3b4252;
	    }

	    #temperature {
	      color: #a6da95;
	    }

	    #temperature.critical {
	      color: #bf616a;
	    }

	    #idle_inhibitor {
	      color: #ebcb8b;
	    }

	    #tray {
	      margin-right: 0px;
	      border-bottom: 0;
	    }

	    #custom-launcher, #custom-power {
	      border-style: hidden;
	      margin-top: 2px;    
	    }

	    #window {
	      border-style: hidden;
	      margin-top: 1px;  
	    }

	    #mode {
	      margin-bottom:3px;
	    }

	    #custom-keyboard-layout {
	      color: #d08770;
	    }
		'';
  };
}
