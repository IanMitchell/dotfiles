function findport --wraps lsof
  if test (count $argv) -ne 1
    echo "Usage: findport <port>"
    return 1
  end

  lsof -nP -iTCP:$argv[1] -sTCP:LISTEN
end
