function findport
  lsof -nP -iTCP -sTCP:LISTEN | grep $argv
end
