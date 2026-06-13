{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = false;
    withPython3 = false;
    withRuby = false;
    sideloadInitLua = true;
    extraPackages = with pkgs; [
      # Language Servers
      awk-language-server
      bash-language-server
      cmake-language-server
      glsl_analyzer
      haskell-language-server
      lua-language-server
      nixd
      python312Packages.jedi-language-server
      rust-analyzer
      typescript-language-server
      vscode-langservers-extracted
      jdt-language-server
      gopls
      intelephense

      # Linters
      python312Packages.flake8

      # Formatters
      alejandra
      black
      indent
      jq
      prettier
      rustfmt
      shfmt
      stylua
      taplo
      php84Packages.php-cs-fixer

      # Tools
      clang-tools # Provides clangd, clang-format & clang-tidy
      tree-sitter
    ];
  };
}
