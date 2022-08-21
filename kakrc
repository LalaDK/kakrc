add-highlighter global/ number-lines
add-highlighter global/ show-whitespaces
evaluate-commands %sh{
  plugins="$kak_config/plugins"
  mkdir -p "$plugins"
  [ ! -e "$plugins/plug.kak" ] && \
    git clone -q https://github.com/andreyorst/plug.kak.git "$plugins/plug.kak"
    printf "%s\n" "source '$plugins/plug.kak/rc/plug.kak'"
}
plug "andreyorst/plug.kak" noload
plug "andreyorst/fzf.kak" config %{
  map global normal <c-p> ': fzf-mode<ret>'
} defer fzf-file %{
  set-option global fzf_file_command 'rg' # 'ag', 'fd', or 'find'
} defer fzf-grep %{
  set-option global fzf_grep_command 'rg' # 'ag', or 'find'
}

plug "caksoylar/kakoune-smooth-scroll" config %{
  hook global WinCreate [^*].* %{
    hook -once window WinDisplay .* %{
      smooth-scroll-enable
    }
  }
}

plug "gustavo-hms/luar" %{
      require-module luar
}
plug "ABuffSeagull/kakoune-vue"
plug "insipx/kak-crosshairs"
plug "caksoylar/kakoune-mysticaltutor" theme %{ colorscheme mysticaltutor }
set-option global tabstop 2
set-option global indentwidth 2
map global insert <tab> '<a-;><a-gt>'
map global insert <s-tab> '<a-;><a-lt>'
plug "enricozb/tabs.kak" %{
  set-option global modelinefmt_tabs '%val{cursor_line}:%val{cursor_char_column} {{context_info}} {{mode_info}}'
  map global normal ^ q
  map global normal <a-^> Q
  map global normal q b
  map global normal Q B
  map global normal <a-q> <a-b>
  map global normal <a-Q> <a-B>

  map global normal b ': enter-user-mode tabs<ret>' -docstring 'tabs'
  map global normal B ': enter-user-mode -lock tabs<ret>' -docstring 'tabs (lock)'
}
plug "krornus/kakoune-toggle-map" %{
  plug "krornus/kakoune-hlsearch" %{
    toggle-map global normal <F3> hlsearch-on hlsearch-off
  }
}
set-option global tabs_overlow "shrink"
set-option -add global ui_options terminal_status_on_top=yes

hook global BufSetOption filetype=(vue|javascript) %{
  set-option buffer lintcmd "npm exec eslint -- --config .eslintrc.json --format unix %val{buffile}"
  set-option buffer formatcmd "TMP=$(mktemp);cp '%val{buffile}' $TMP;npm exec eslint -- --quiet --config .eslintrc.json --format unix --fix $TMP > /dev/null;cat $TMP"
}

plug "krornus/kakoune-toggle-map" %{
  plug "krornus/kakoune-hlsearch" %{
    toggle-map global normal <F3> hlsearch-on hlsearch-off
  }
}

hook global WinSetOption filetype=(c|cpp) %{
    clang-enable-autocomplete 
    clang-enable-diagnostics
}

plug "kak-lsp/kak-lsp" do %{
    cargo install --locked --force --path .
    # optional: if you want to use specific language servers
    mkdir -p ~/.config/kak-lsp
    cp -n kak-lsp.toml ~/.config/kak-lsp/
}

lsp-enable
