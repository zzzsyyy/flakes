let
  dir = ".config/ibus/rime";
in
{
  home.file."${dir}/default.custom.yaml".source = ./custom/default.custom.yaml;
  home.file."${dir}/double_pinyin_flypy.custom.yaml".source = ./custom/double_pinyin_flypy.custom.yaml;
  home.file."${dir}/rime_ice.custom.yaml".source = ./custom/rime_ice.custom.yaml;
}
