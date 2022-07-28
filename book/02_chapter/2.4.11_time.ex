defmodule MyTime do
  def main do
    # TIME
    time = ~T[22:05:30.01]
    time.hour # |> IO.inspect # 22
    time.minute # |> IO.inspect # 5
    time.second # |> IO.inspect # 30
    # time.time_zone  |> IO.inspect # (KeyError) key :time_zone not found in: ~T[22:05:30.01]

    {:ok, time2} = Time.new(23, 23, 23) # |> IO.inspect # {:ok, ~T[22:05:03]}

    (time == time2) # |> IO.inspect # false
    (time < time2) # |> IO.inspect # true
    Time.compare(time, time2) # |> IO.inspect # :lt


    # NAIVE
    naive_time = ~N[2022-07-28 19:51:01]
    naive_time.hour # |> IO.inspect # 19
    naive_time.minute # |> IO.inspect # 51
    naive_time.second # |> IO.inspect # 1


    # DATETIME
    # https://hexdocs.pm/elixir/DateTime.html
    {:ok, dt} = DateTime.new(~D[2022-07-28], ~T[19:51:01]) # |> IO.inspect # {:ok, ~U[2022-07-28 19:51:01Z]}
    dt.time_zone #|> IO.inspect # "Etc/UTC"

    # NOW
    DateTime.now("Etc/UTC") # |> IO.inspect # {:ok, ~U[2022-07-28 19:04:43.065221Z]} - London + 1
    datetime = DateTime.utc_now() # |> IO.inspect # ~U[2022-07-28 18:53:02.011554Z]
    london_time = DateTime.add(DateTime.utc_now(), 3600, :second) # |> IO.inspect #


    # CONVERSIONS
    # TO
    DateTime.to_date(london_time) # |> IO.inspect # ~D[2022-07-28]
    DateTime.to_naive(london_time) # |> IO.inspect # ~N[2022-07-28 20:08:43.531795]
    DateTime.to_time(london_time) # |> IO.inspect # ~T[20:08:43.531795]
    DateTime.to_string(london_time) # |> IO.inspect # "2022-07-28 20:08:43.531795Z"
    DateTime.to_unix(london_time) # |> IO.inspect # 1659038923


    # FROM
    # @spec from_iso8601(String.t(), Calendar.calendar()) ::
    # {:ok, t(), Calendar.utc_offset()} | {:error, atom()}
    DateTime.from_iso8601("2022-07-28T19:51:01+01:00") # |> IO.inspect # {:ok, ~U[2022-07-28 18:51:01Z], 3600}
    DateTime.from_unix(1659038923) # |> IO.inspect # {:ok, ~U[2022-07-28 20:08:43Z]}
    DateTime.from_naive(~N[2022-07-28 20:08:43.531795], "Etc/UTC") # |> IO.inspect # {:ok, ~U[2022-07-28 20:08:43.531795Z]}
    {:ok, datetime} = DateTime.from_naive(naive_time, "Etc/UTC") # |> IO.inspect # {:ok, ~U[2022-07-28 19:51:01Z]}


    # ADD
    a = DateTime.add(datetime, 3600, :second) # |> IO.inspect # ~U[2022-07-28 20:51:01Z]
    b = DateTime.add(datetime, -3600, :second) # |> IO.inspect # ~U[2022-07-28 18:51:01Z]


    # DIFF
    DateTime.diff(a, b) # |> IO.inspect # 7200 seconds


    # MISC
    DateTime.truncate(london_time, :second) # |> IO.inspect # ~U[2022-07-28 20:13:32Z]


    # NAIVEDATETIME
    # https://hexdocs.pm/elixir/NaiveDateTime.htm
    {:ok, ndt} = NaiveDateTime.new(~D[2022-07-28], ~T[19:51:01]) # |> IO.inspect # {:ok, ~N[2022-07-28 19:51:01]}
    # ndt.time_zone # (KeyError) key :time_zone not found in: ~N[2022-07-28 19:51:01]

  end
end

MyTime.main()
