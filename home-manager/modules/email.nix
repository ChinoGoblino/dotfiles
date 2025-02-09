{ config, pkgs, ... }:

{
  accounts.email.accounts = {
    oxn = {
      address = "webmaster@oxn.sh";
      userName = "webmaster@oxn.sh";
      realName = "Webmaster";
      primary = false;

      imap = {
        host = "imap.purelymail.com";
        port = 993;
        tls.enable = true;
      };

      smtp = {
        host = "smtp.purelymail.com";
        port = 465;
        tls.enable = true;
      };

      thunderbird.enable = true;
    };

    ethonium = {
      address = "escott@ethonium.com";
      userName = "escott@ethonium.com";
      realName = "Ethonium";
      primary = true;

      imap = {
        host = "imap.purelymail.com";
        port = 993;
        tls.enable = true;
      };

      smtp = {
        host = "smtp.purelymail.com";
        port = 465;
        tls.enable = true;
      };

      thunderbird.enable = true;
    };

    unsw = {
      address = "z5588665@ad.unsw.edu.au";
      userName = "z5588665@ad.unsw.edu.au";
      realName = "z5588665";
      primary = false;

      imap = {
        host = "outlook.office365.com";
        port = 993;
        tls.enable = true;
      };

      smtp = {
        host = "smtp.office365.com";
        port = 587;
        tls.enable = true;
      };

      thunderbird = {
        enable = true;
        settings = id: {
          "mail.smtpserver.smtp_${id}.authMethod" = 10;
          "mail.server.server_${id}.authMethod" = 10;
        };
      };
    };

    devsoc = {
      address = "ethan.scott@devsoc.app";
      userName = "ethan.scott@devsoc.app";
      realName = "DevSoc";
      primary = false;

      imap = {
        host = "imap.gmail.com";
        port = 993;
        tls.enable = true;
      };

      smtp = {
        host = "smtp.gmail.com";
        port = 465;
        tls.enable = true;
      };

      thunderbird = {
        enable = true;
        settings = id: {
          "mail.smtpserver.smtp_${id}.authMethod" = 10;
          "mail.server.server_${id}.authMethod" = 10;
        };
      };
    };
  };

  programs.thunderbird = {
    enable = true;
    profiles.chino = {
      isDefault = true;
    };
  };
}
