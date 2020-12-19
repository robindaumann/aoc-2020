#!/usr/bin/env elixir

[day] = System.argv()

File.write!("lib/day_#{day}.ex", EEx.eval_file("lib/day.eex", day: day))
IO.puts("Created module file.")

File.write!("test/day_#{day}_test.exs", EEx.eval_file("lib/test.eex", day: day))
IO.puts("Created test file.")

:inets.start()
:ssl.start()

url_day = String.trim_leading(day, "0")
url = 'https://adventofcode.com/2020/day/#{url_day}/input'

cookie = File.read!("cookie.txt")
headers = [{'Cookie', 'session=#{cookie}'}]

{:ok, {{_, 200, 'OK'}, _hdrs, content}} = :httpc.request(:get, {url, headers}, [], [])

File.write!("input/day_#{day}.txt", content)
IO.puts("Created input file.")
