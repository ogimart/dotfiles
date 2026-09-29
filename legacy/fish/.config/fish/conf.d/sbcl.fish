function sbcl --description 'Run roswell sbcl'
  ros run -- $argv
end

function sbcl-repl --description 'Run roswell sbcl with rlwrap'
  rlwrap ros run -- $argv
end

function sbcl-swank --description 'Run roswell sbcl swank'
  rlwrap ros run -- \
    --eval '(ql:quickload :swank)' \
    --eval '(swank:create-server :dont-close t)'
end

function sbcl-exe --description 'todo'
end
