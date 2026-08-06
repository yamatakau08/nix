{ config, pkgs, ... }:

{
  # DDC/CI で外部モニタ(HDMI / DisplayPort)の輝度を制御
  hardware.i2c.enable = true; # i2c-dev ロード + i2c グループ作成 + udev ルール
  environment.systemPackages = [ pkgs.ddcutil ];
  users.users."yama".extraGroups = [ "i2c" ];  # 既存 extraGroups とマージされる
}
