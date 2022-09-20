{ lib, ... }:

{
  format = "[ ](bold yellow) $directory(bold blue)$git_branch$git_status[\\$](bold) ";
  scan_timeout = 60;
  add_newline = false;
  line_break = {
    disabled = true;
  };
  directory = {
    style = "bold blue";
  };
  cmd_duration = {
    format = "[$duration]($style) ";
  };
  status = {
    disabled = false;
    format = "[''$symbol $status''](''$style'') ";
    not_found_symbol = "";
    not_executable_symbol = "";
    sigint_symbol = "ﭦ";
    map_symbol = true;
  };
  git_branch = {
    format = "[$symbol$branch]($style) ";
  };
  package = {
    format = "[$symbol$version]($style) ";
    symbol = " ";
  };
  python = {
    format = "[''${symbol}${pyenv_prefix}(${version} '')(\\(''$virtualenv''\\) )](''$style'')";
    symbol = " ";
  };
  nodejs = {
    format = "[$symbol($version )]($style)";
  };
  php = {
    format = "[$symbol($version )]($style)";
    symbol = " ";
  };
  java = {
    format = "[${symbol}(${version} )]($style)";
    symbol = " ";
  };
  rust = {
    format = "[$symbol($version )]($style)";
  };
  nix_shell = {
    impure_msg = "[impure shell](bold red)";
    pure_msg = "[pure shell](bold green)";
    format = "via [☃️ $state( \\($name\\))](bold blue) ";
  };
  nim = {
    style = "yellow";
    symbol = " ";
  };
  golang = {
    format = "[$symbol($version )]($style)";
    symbol = " ";
  };
}
