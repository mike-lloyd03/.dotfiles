# Nushell Config File
source ~/.config/nushell/aliases.nu
source ~/.config/nushell/themes.nu
# source ~/.config/nushell/completions.nu
source ~/.config/nushell/functions.nu

# use completions *
use functions *

# External completer example
let carapace_completer = {|spans| 
    carapace $spans.0 nushell $spans | from json
}

$env.config = {
  color_config: $dark_theme
  use_grid_icons: true
  footer_mode: "25"
  float_precision: 2
  use_ansi_coloring: true
  edit_mode: vi
  shell_integration: true
  show_banner: false
  render_right_prompt_on_last_line: true

  ls: {
      use_ls_colors: true
      clickable_links: true
  }

  rm: {
      always_trash: false
  }

  # cd: {
  #     abbreviations: false
  # }

  history: {
      max_size: 10000
      sync_on_enter: true
      file_format: "plaintext"
  }

  filesize: {
      metric: false
      format: "auto"
  }

  completions: {
      case_sensitive: false
      quick: true  # set this to false to prevent auto-selecting completions when only one remains
      partial: true  # set this to false to prevent partial filling of the prompt
      algorithm: "prefix"  # prefix, fuzzy
      external: {
          enable: true
          completer: $carapace_completer
          max_results: 100
      }
  }

  table: {
      mode: rounded
      index_mode: auto
      trim: {
        methodology: wrapping,
        wrapping_try_keep_words: true,
      }
  }

  hooks: {
    pre_prompt: [{
      null
    }]
    pre_execution: [{
      null
    }]
    env_change: {
      PWD: [{|before, after|
        null
      }]
    }
  }

  menus: [
      {
        name: completion_menu
        only_buffer_difference: false
        marker: "| "
        type: {
            layout: columnar
            columns: 4
            col_width: 20
            col_padding: 2
        }
        style: {
            text: white
            selected_text: white_reverse
            description_text: yellow
        }
      }
      {
        name: history_menu
        only_buffer_difference: true
        marker: "? "
        type: {
            layout: list
            page_size: 10
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
      }
      {
        name: help_menu
        only_buffer_difference: true
        marker: "? "
        type: {
            layout: description
            columns: 4
            col_width: 20   # Optional value. If missing all the screen width is used to calculate column width
            col_padding: 2
            selection_rows: 4
            description_rows: 10
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
      }
      # Example of extra menus created using a nushell source
      # Use the source field to create a list of records that populates
      # the menu
      {
        name: commands_menu
        only_buffer_difference: false
        marker: "# "
        type: {
            layout: columnar
            columns: 4
            col_width: 20
            col_padding: 2
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
        source: { |buffer, position|
            $nu.scope.commands
            | where command =~ $buffer
            | each { |it| {value: $it.command description: $it.usage} }
        }
      }
      {
        name: vars_menu
        only_buffer_difference: true
        marker: "# "
        type: {
            layout: list
            page_size: 10
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
        source: { |buffer, position|
            $nu.scope.vars
            | where name =~ $buffer
            | sort-by name
            | each { |it| {value: $it.name description: $it.type} }
        }
      }
      {
        name: commands_with_description
        only_buffer_difference: true
        marker: "# "
        type: {
            layout: description
            columns: 4
            col_width: 20
            col_padding: 2
            selection_rows: 4
            description_rows: 10
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
        source: { |buffer, position|
            $nu.scope.commands
            | where command =~ $buffer
            | each { |it| {value: $it.command description: $it.usage} }
        }
      }
  ]
  keybindings: [
    {
      name: completion_menu
      modifier: none
      keycode: tab
      mode: [emacs, vi_normal, vi_insert] # Options: emacs vi_normal vi_insert
      event: {
        until: [
          { send: menu name: completion_menu }
          { send: menunext }
        ]
      }
    }
    {
      name: completion_previous
      modifier: shift
      keycode: backtab
      mode: [emacs, vi_normal, vi_insert] # Note: You can add the same keybinding to all modes by using a list
      event: { send: menuprevious }
    }
    # {
    #   name: history_menu
    #   modifier: control
    #   keycode: char_r
    #   mode: vi_normal
    #   event: { send: menu name: history_menu }
    # }
    {
      name: next_page
      modifier: control
      keycode: char_x
      mode: vi_normal
      event: { send: menupagenext }
    }
    {
      name: undo_or_previous_page
      modifier: none
      keycode: char_u
      mode: vi_normal
      event: {
        until: [
          { send: menupageprevious }
          { edit: undo }
        ]
       }
    }
    {
      name: yank
      modifier: none
      keycode: char_y
      mode: vi_normal
      event: {
        until: [
          {edit: pastecutbufferafter}
        ]
      }
    }
    {
      name: unix-line-discard
      modifier: control
      keycode: char_u
      mode: [emacs, vi_normal, vi_insert]
      event: {
        until: [
          {edit: cutfromlinestart}
        ]
      }
    }
    {
      name: kill-line
      modifier: shift
      keycode: char_d
      mode: vi_normal
      event: {
        until: [
          {edit: cuttolineend}
        ]
      }
    }
    # Keybindings used to trigger the user defined menus
    {
      name: commands_menu
      modifier: control
      keycode: char_t
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menu name: commands_menu }
    }
    {
      name: vars_menu
      modifier: alt
      keycode: char_o
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menu name: vars_menu }
    }
    {
      name: commands_with_description
      modifier: control
      keycode: char_s
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menu name: commands_with_description }
    }
    {
      name: skim_history
      modifier: control
      keycode: char_r
      mode: [emacs, vi_normal, vi_insert]
      event: {
        send: executehostcommand
        cmd: "commandline (history | each { |it| $it.command } | uniq | reverse | str collect (char -i 0) | fzf --read0 --layout=reverse --height=40% -q (commandline) | decode utf-8 | str trim)"
      }
    }
  ]
}
