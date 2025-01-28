{ config, pkgs, ... }:
{
	# udev rules
	services.udev.packages = [
		(pkgs.writeTextFile {
			name = "stm32_udev";
			text = ''
SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374b", GROUP="users", MODE="0666"
			'';
			destination = "/etc/udev/rules.d/50-stm32.rules";
		})
		(pkgs.writeTextFile {
			name = "hackrf_udev";
			text = ''
# HackRF Jawbreaker
ATTR{idVendor}=="1d50", ATTR{idProduct}=="604b", SYMLINK+="hackrf-jawbreaker-%k", MODE="666", GROUP="plugdev"
# HackRF One
ATTR{idVendor}=="1d50", ATTR{idProduct}=="6089", SYMLINK+="hackrf-one-%k", MODE="666", GROUP="plugdev"
# rad1o
ATTR{idVendor}=="1d50", ATTR{idProduct}=="cc15", SYMLINK+="rad1o-%k", MODE="666", GROUP="plugdev"
# NXP Semiconductors DFU mode (HackRF and rad1o)
ATTR{idVendor}=="1fc9", ATTR{idProduct}=="000c", SYMLINK+="nxp-dfu-%k", MODE="666", GROUP="plugdev"
# rad1o "full flash" mode
KERNEL=="sd?", SUBSYSTEM=="block", ENV{ID_VENDOR_ID}=="1fc9", ENV{ID_MODEL_ID}=="0042", SYMLINK+="rad1o-flash-%k", MODE="666", GROUP="plugdev"
# rad1o flash disk
KERNEL=="sd?", SUBSYSTEM=="block", ENV{ID_VENDOR_ID}=="1fc9", ENV{ID_MODEL_ID}=="0082", SYMLINK+="rad1o-msc-%k", MODE="666", GROUP="plugdev"
#
			'';
			destination = "/etc/udev/rules.d/53-hackrf.rules";
		})
	];
}
