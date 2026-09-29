function chez-scheme --description 'Run chez-scheme with libdirs .'
  chez --libdirs . $argv
end

function chibi-repl --description 'Run chibi-scheme with rlwrap'
  rlwrap chibi-scheme $argv
end
