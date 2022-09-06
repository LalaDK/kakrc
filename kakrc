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

plug "caksoylar/kakoune-mysticaltutor" theme %{ colorscheme mysticaltutor }
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
#set-option global tabs_overlow "shrink"
#set-option -add global ui_options terminal_status_on_top=yes

plug "kak-lsp/kak-lsp" do %{
    cargo install --locked --force --path .
    # optional: if you want to use specific language servers
    mkdir -p ~/.config/kak-lsp
    cp -n kak-lsp.toml ~/.config/kak-lsp/
}

#map global user l %{:enter-user-mode lsp<ret>} -docstring "LSP mode"
map global insert <tab> '<a-;>:try lsp-snippets-select-next-placeholders catch %{ execute-keys -with-hooks <lt>tab> }<ret>' -docstring 'Select next snippet placeholder'
map global object a '<a-semicolon>lsp-object<ret>' -docstring 'LSP any symbol'
map global object <a-a> '<a-semicolon>lsp-object<ret>' -docstring 'LSP any symbol'
map global object e '<a-semicolon>lsp-object Function Method<ret>' -docstring 'LSP function or method'
map global object k '<a-semicolon>lsp-object Class Interface Struct<ret>' -docstring 'LSP class interface or struct'
lsp-enable
lsp-auto-signature-help-enable
lsp-auto-hover-insert-mode-enable
lsp-auto-hover-enable
set global lsp_hover_anchor true

set-option global tabstop 2
set-option global indentwidth 2
map global insert <tab> '<a-;><a-gt>'
map global insert <s-tab> '<a-;><a-lt>'
