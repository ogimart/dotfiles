function fish_prompt --description 'Custom prompt'
    set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status # Export for __fish_print_pipestatus.

    set -l normal (set_color --reset)
    set -l white (set_color white)
    set -l yellow (set_color yellow)
    set -l cyan (set_color cyan)
    set -l blue (set_color blue)
    set -l red (set_color red)

    set -l suffix '> '
    fish_is_root_user; and set suffix '# '

    # Python virtual environment
    set -l venv_name ""
    if test -n "$VIRTUAL_ENV"
        set -l base_name (basename "$VIRTUAL_ENV")
        set venv_name "($base_name) "
    end

    # Write pipestatus
    set -l status_color (set_color $fish_color_status)
    set -l pipe_status (__fish_print_pipestatus "[" "]" "|" \
      "$status_color" "$status_color" $last_pipestatus)

    set -l clean_vcs (fish_vcs_prompt | string trim -l)
    test -n "$clean_vcs"; and set clean_vcs " $clean_vcs"

    set -l prompt_line (echo -n -s \
      $red $venv_name \
      $cyan "$USER@$hostname" \
      $white ":" \
      $blue (prompt_pwd) \
      $yellow $clean_vcs
    )
    set -l prompt_status (echo -n -s $normal $pipe_status)

    # Calculate 2/3 of the current terminal window width; split the prompt
    set -l prompt_len (string length --visible "$prompt_line$prompt_status")
    set -l max_len (math "$COLUMNS * 2 / 3")

    if test $prompt_len -gt $max_len
    # if test $prompt_len -gt 6
      echo -n -s $prompt_line \n $prompt_status $suffix
    else
      echo -n -s $prompt_line " " $prompt_status $suffix
    end
end
