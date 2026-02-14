{ pkgs, ... }:
{
  programs.vim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      ale
      fzf-vim
      coc-git
      vim-fugitive
      vim-nerdtree-syntax-highlight
      vim-airline
      vim-easy-align
      vim-git
      nerdtree
      nerdcommenter
      lightline-vim
      vim-floaterm
    ];
    extraConfig = ''
      " ===========
      " - Globals -
      " ===========

      set backspace=indent,eol,start

      set encoding=utf-8  " The encoding displayed.
      set fileencoding=utf-8  " The encoding written to file.
      set t_Co=256

      "cycle line numbers/relative line numbers/no line numbers. default: relative
      function! NumberToggle()
      if(&relativenumber == 1)
      set number
      set norelativenumber
      elseif(&relativenumber == 0 && &number == 1)
      set nonumber
      else
      set relativenumber
      set number
      endif
      endfunc
      map <silent><F10> :call NumberToggle()<CR>
      set number
      set relativenumber

      " ==============
      " - Decorators -
      " ==============

      " --- Vertical Separator ---
      highlight VertSplit cterm=NONE
      set fillchars+=vert:\▏

      " --- NerdTree On Startup ---
      let NERDTreeShowHidden=1
      autocmd VimEnter * NERDTree
      autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
      autocmd VimEnter * wincmd w

      " --- Floating fzf.vim Pane ---
      let g:fzf_preview_window = 'right:50%'
      let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6  }  }

      " ==================
      " - Autocompletion -
      " ==================

      set completeopt=menu,menuone,preview,noselect,noinsert


      " =====================
      " - Command Shortcuts -
      " =====================

      " --- Terminal ---
      noremap <leader>/ :BTerm<cr>

      " ALE
      let g:ale_completion_enabled = 1
      let g:ale_linters = { 'python': ['pycodestyle', 'pydocstyle', 'pyls', 'flake8', 'mypy', 'pylint', 'pyright'] }

      syntax on

      " ===================
      " - Custom Commands -
      " ===================

      " --- Terminal ---
      function BTerm()
        execute "below term++rows=15"
      endfunction
      command! BTerm call BTerm()

      function! ReSource()
          let l:winview = winsaveview()
          :source ~/.vimrc<cr>
          call winrestview(l:winview)
      endfunction

        " function call
        nnoremap <leader>z :call ReSource()<cr>


      " ==========================
      " - File Specific Commands -
      " ==========================

      " --- Python ---
      au BufNewFile,BufRead *.py
          \ set tabstop=4 |
          \ set softtabstop=4 |
          \ set shiftwidth=4 |
          \ set textwidth=79 |
          \ set expandtab |
          \ set autoindent |
          \ set fileformat=unix

      " ===================
      " - Text Formatting -
      " ===================

      " --- Remove Trailing Whitespaces ---
      autocmd BufWritePre * %s/\s\+$//e
    '';
  };
}
