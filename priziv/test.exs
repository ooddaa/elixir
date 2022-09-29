"./Priziv1volna.txt"
|> File.stream!()
|> Stream.map(&String.replace(&1, ["\n", "\t"], " "))
|> Stream.map(&String.trim_trailing/1)
|> Stream.map(&String.split(&1, " "))
|> Stream.map(fn
  record ->
    {:ok, dob} =
      Enum.at(record, 3)
      |> String.split(".")
      |> Enum.map(&String.to_integer/1)
      |> then(fn [day, month, year] -> Date.new(year, month, day) end)


    rest = Enum.slice(record, 4..-1)
    passport_num = Enum.filter(rest, fn str ->
      case String.length(str) == 10 do
        true -> case Integer.parse(str) do
          :error -> false
          { int, _ } -> str
        end
        false -> false
      end
    end) |> Enum.at(0)

    address = Enum.slice(rest, 0..Enum.find_index(rest, &(&1 == passport_num))-1) |> Enum.join(" ")
    passport_auth = Enum.slice(rest, Enum.find_index(rest, &(&1 == passport_num))+1..-1) |> Enum.join(" ")

    {Enum.at(record, 0), Enum.at(record, 1), Enum.at(record, 2), dob, passport_num, passport_auth, address}
end)
|> Enum.take(5)
|> Enum.map(& &1)
|> IO.inspect()
