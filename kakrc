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
plug "andreyorst/fzf.kak"
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

map global normal <c-p> ': fzf-mode<ret>'
colorscheme "tomorrow-night"
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
set-option global tabs_overlow "shrink"
set-option -add global ui_options terminal_status_on_top=yes
