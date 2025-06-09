{ theme, ... }:

{
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
    "x/dm/slick-greeter" = {
      cursor-theme-name = "Adwaita";
      icon-theme-name = "Papirus-Dark";
      theme-name = "Mint-Y-Dark-Grey";
      font-name = "${theme.font} ${theme.font-size}";
    };
    "org/gnome/desktop/interface" = {
      font-name = "${theme.font} ${theme.font-size}";
      document-font-name = "${theme.font} ${theme.font-size}";
      monospace-font-name = "${theme.font} ${theme.font-size}";
    };
    "org/x/apps/portal" = {
      color-scheme = "prefer-dark";
    };
    "org/nemo/desktop" = {
      font = "${theme.font} ${theme.font-size}";
    };
    "org/cinnamon" = {
      enabled-applets = "['panel1:left:0:menu@cinnamon.org:0', 'panel1:left:1:separator@cinnamon.org:1', 'panel1:left:4:grouped-window-list@cinnamon.org:2', 'panel1:right:4:systray@cinnamon.org:3', 'panel1:right:5:xapp-status@cinnamon.org:4', 'panel1:right:7:notifications@cinnamon.org:5', 'panel1:right:8:printers@cinnamon.org:6', 'panel1:right:9:keyboard@cinnamon.org:8', 'panel1:right:10:favorites@cinnamon.org:9', 'panel1:right:11:network@cinnamon.org:10', 'panel1:right:12:sound@cinnamon.org:11', 'panel1:right:13:power@cinnamon.org:12', 'panel1:right:15:calendar@cinnamon.org:13', 'panel1:right:16:cornerbar@cinnamon.org:14', 'panel1:left:2:workspace-switcher@cinnamon.org:15', 'panel1:right:6:separator@cinnamon.org:15', 'panel1:right:3:separator@cinnamon.org:16', 'panel1:right:14:separator@cinnamon.org:17', 'panel1:left:3:separator@cinnamon.org:18']";
      hotcorner-layout = "['expo:true:0', 'scale:true:0', 'scale:false:0', 'desktop:true:0']";
      panel-zone-symbolic-icon-sizes = "[{\"panelId\": 1, \"left\": 28, \"center\": 28, \"right\": 16}]";
      panel-zone-icon-sizes = "[{\"panelId\": 1, \"left\": 0, \"center\": 0, \"right\": 16}]";
    };
    "org/cinnamon/desktop/interface" = {
      gtk-theme = "Mint-Y-Dark-Grey";
      icon-theme = "Papirus-Dark";
      cursor-theme = "Adwaita";
      font-name = "${theme.font} ${theme.font-size}";
    };
    "org/cinnamon/theme" = {
      name = "Mint-Y-Dark-Grey";
    };
    "org/cinnamon/desktop/wm/preferences" = {
      titlebar-font = "${theme.font} ${theme.font-size}";
      theme = "Mint-Y-Dark-Grey";
      button-layout = ":minimize,maximize,close";
    };
    "org/cinnamon/desktop/background" = {
      picture-uri = "file://${./config/wallpaper/16.jpeg}";
    };
    "org/cinnamon/desktop/applications/terminal" = {
      exec = "ghostty";
      exec-arg = "--working-directory";
    };
  };
}
