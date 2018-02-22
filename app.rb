puts "http://localhost:8080/render?target=ship&from=-10min"
loop do
  puts "We've just docked in the harbor."
  ship = Random.rand(22)
  `echo -n "ship:#{ship}|c" | nc -u -q1 veneurcont 8126`
  sleep(60)
end
