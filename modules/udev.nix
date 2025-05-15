{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    rtl-sdr
  ];

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
    (pkgs.writeTextFile {
      name = "rtl-sdr";
      text = ''
# original RTL2832U vid/pid (hama nano, for example)
SUBSYSTEMS=="usb", ATTRS{idVendor}=="0bda", ATTRS{idProduct}=="2832", MODE:="0666"

# RTL2832U OEM vid/pid, e.g. ezcap EzTV668 (E4000), Newsky TV28T (E4000/R820T) etc.
SUBSYSTEMS=="usb", ATTRS{idVendor}=="0bda", ATTRS{idProduct}=="2838", MODE:="0666"

# DigitalNow Quad DVB-T PCI-E card (4x FC0012?)
SUBSYSTEMS=="usb", ATTRS{idVendor}=="0413", ATTRS{idProduct}=="6680", MODE:="0666"

# Leadtek WinFast DTV Dongle mini D (FC0012)
SUBSYSTEMS=="usb", ATTRS{idVendor}=="0413", ATTRS{idProduct}=="6f0f", MODE:="0666"

# Genius TVGo DVB-T03 USB dongle (Ver. B)
SUBSYSTEMS=="usb", ATTRS{idVendor}=="0458", ATTRS{idProduct}=="707f", MODE:="0666"

# Terratec Cinergy T Stick Black (rev 1) (FC0012)
SUBSYSTEMS=="usb", ATTRS{idVendor}=="0ccd", ATTRS{idProduct}=="00a9", MODE:="0666"

# Terratec NOXON rev 1 (FC0013)
SUBSYSTEMS=="usb", ATTRS{idVendor}=="0ccd", ATTRS{idProduct}=="00b3", MODE:="0666"

# Terratec Deutschlandradio DAB Stick (FC0013)
SUBSYSTEMS=="usb", ATTRS{idVendor}=="0ccd", ATTRS{idProduct}=="00b4", MODE:="0666"

# Terratec NOXON DAB Stick - Radio Energy (FC0013)
SUBSYSTEMS=="usb", ATTRS{idVendor}=="0ccd", ATTRS{idProduct}=="00b5", MODE:="0666"

# Terratec Media Broadcast DAB Stick (FC0013)
SUBSYSTEMS=="usb", ATTRS{idVendor}=="0ccd", ATTRS{idProduct}=="00b7", MODE:="0666"

# Terratec BR DAB Stick (FC0013)
SUBSYSTEMS=="usb", ATTRS{idVendor}=="0ccd", ATTRS{idProduct}=="00b8", MODE:="0666"

# Terratec WDR DAB Stick (FC0013)
SUBSYSTEMS=="usb", ATTRS{idVendor}=="0ccd", ATTRS{idProduct}=="00b9", MODE:="0666"

# Terratec MuellerVerlag DAB Stick (FC0013)
SUBSYSTEMS=="usb", ATTRS{idVendor}=="0ccd", ATTRS{idProduct}=="00c0", MODE:="0666"

# Terratec Fraunhofer DAB Stick (FC0013)
SUBSYSTEMS=="usb", ATTRS{idVendor}=="0ccd", ATTRS{idProduct}=="00c6", MODE:="0666"

# Terratec Cinergy T Stick RC (Rev.3) (E4000)
SUBSYSTEMS=="usb", ATTRS{idVendor}=="0ccd", ATTRS{idProduct}=="00d3", MODE:="0666"

# Terratec T Stick PLUS (E4000)
SUBSYSTEMS=="usb", ATTRS{idVendor}=="0ccd", ATTRS{idProduct}=="00d7", MODE:="0666"

# Terratec NOXON rev 2 (E4000)
SUBSYSTEMS=="usb", ATTRS{idVendor}=="0ccd", ATTRS{idProduct}=="00e0", MODE:="0666"

# PixelView PV-DT235U(RN) (FC0012)
SUBSYSTEMS=="usb", ATTRS{idVendor}=="1554", ATTRS{idProduct}=="5020", MODE:="0666"

# Astrometa DVB-T/DVB-T2 (R828D)
SUBSYSTEMS=="usb", ATTRS{idVendor}=="15f4", ATTRS{idProduct}=="0131", MODE:="0666"

# HanfTek DAB+FM+DVB-T
SUBSYSTEMS=="usb", ATTRS{idVendor}=="15f4", ATTRS{idProduct}=="0133", MODE:="0666"

# Compro Videomate U620F (E4000)
SUBSYSTEMS=="usb", ATTRS{idVendor}=="185b", ATTRS{idProduct}=="0620", MODE:="0666"

# Compro Videomate U650F (E4000)
SUBSYSTEMS=="usb", ATTRS{idVendor}=="185b", ATTRS{idProduct}=="0650", MODE:="0666"

# Compro Videomate U680F (E4000)
SUBSYSTEMS=="usb", ATTRS{idVendor}=="185b", ATTRS{idProduct}=="0680", MODE:="0666"

# GIGABYTE GT-U7300 (FC0012)
SUBSYSTEMS=="usb", ATTRS{idVendor}=="1b80", ATTRS{idProduct}=="d393", MODE:="0666"

# DIKOM USB-DVBT HD
SUBSYSTEMS=="usb", ATTRS{idVendor}=="1b80", ATTRS{idProduct}=="d394", MODE:="0666"

# Peak 102569AGPK (FC0012)
SUBSYSTEMS=="usb", ATTRS{idVendor}=="1b80", ATTRS{idProduct}=="d395", MODE:="0666"

# KWorld KW-UB450-T USB DVB-T Pico TV (TUA9001)
SUBSYSTEMS=="usb", ATTRS{idVendor}=="1b80", ATTRS{idProduct}=="d397", MODE:="0666"

# Zaapa ZT-MINDVBZP (FC0012)
SUBSYSTEMS=="usb", ATTRS{idVendor}=="1b80", ATTRS{idProduct}=="d398", MODE:="0666"

# SVEON STV20 DVB-T USB & FM (FC0012)
SUBSYSTEMS=="usb", ATTRS{idVendor}=="1b80", ATTRS{idProduct}=="d39d", MODE:="0666"

# Twintech UT-40 (FC0013)
SUBSYSTEMS=="usb", ATTRS{idVendor}=="1b80", ATTRS{idProduct}=="d3a4", MODE:="0666"

# ASUS U3100MINI_PLUS_V2 (FC0013)
SUBSYSTEMS=="usb", ATTRS{idVendor}=="1b80", ATTRS{idProduct}=="d3a8", MODE:="0666"

# SVEON STV27 DVB-T USB & FM (FC0013)
SUBSYSTEMS=="usb", ATTRS{idVendor}=="1b80", ATTRS{idProduct}=="d3af", MODE:="0666"

# SVEON STV21 DVB-T USB & FM
SUBSYSTEMS=="usb", ATTRS{idVendor}=="1b80", ATTRS{idProduct}=="d3b0", MODE:="0666"

# Dexatek DK DVB-T Dongle (Logilink VG0002A) (FC2580)
SUBSYSTEMS=="usb", ATTRS{idVendor}=="1d19", ATTRS{idProduct}=="1101", MODE:="0666"

# Dexatek DK DVB-T Dongle (MSI DigiVox mini II V3.0)
SUBSYSTEMS=="usb", ATTRS{idVendor}=="1d19", ATTRS{idProduct}=="1102", MODE:="0666"

# Dexatek DK 5217 DVB-T Dongle (FC2580)
SUBSYSTEMS=="usb", ATTRS{idVendor}=="1d19", ATTRS{idProduct}=="1103", MODE:="0666"

# MSI DigiVox Micro HD (FC2580)
SUBSYSTEMS=="usb", ATTRS{idVendor}=="1d19", ATTRS{idProduct}=="1104", MODE:="0666"

# Sweex DVB-T USB (FC0012)
SUBSYSTEMS=="usb", ATTRS{idVendor}=="1f4d", ATTRS{idProduct}=="a803", MODE:="0666"

# GTek T803 (FC0012)
SUBSYSTEMS=="usb", ATTRS{idVendor}=="1f4d", ATTRS{idProduct}=="b803", MODE:="0666"

# Lifeview LV5TDeluxe (FC0012)
SUBSYSTEMS=="usb", ATTRS{idVendor}=="1f4d", ATTRS{idProduct}=="c803", MODE:="0666"

# MyGica TD312 (FC0012)
SUBSYSTEMS=="usb", ATTRS{idVendor}=="1f4d", ATTRS{idProduct}=="d286", MODE:="0666"

# PROlectrix DV107669 (FC0012)
SUBSYSTEMS=="usb", ATTRS{idVendor}=="1f4d", ATTRS{idProduct}=="d803", MODE:="0666"
      '';
      destination = "/etc/udev/rules.d/10-rtl-sdr.rules";
    })
  ];

  boot.blacklistedKernelModules = [ "dvb_usb_rtl28xxu" ];
}
