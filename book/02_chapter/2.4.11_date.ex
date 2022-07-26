defmodule MyDateTime do
  # https://hexdocs.pm/elixir/Date.html
  def main do

    # DATE
    date = ~D[2022-07-26]
    date.day # |> IO.inspect # 26
    date.month # |> IO.inspect # 7
    date.year # |> IO.inspect # 2022
    date.calendar # |> IO.inspect # Elixir.Calendar.ISO

    # COMPARE DATES
    date2 = ~D[2023-07-26]
    date == date2 # |> IO.inspect # false
    date < date2 # |> IO.inspect # true
    date <= date2 # |> IO.inspect # true
    Date.compare(~D[2022-07-26], date2) # |> IO.inspect # :lt
    Date.compare(date2, ~D[2022-07-26]) # |> IO.inspect # :gt
    Date.compare(~D[2022-07-26], ~D[2022-07-26]) # |> IO.inspect # :eq

    { :ok, date3 } = Date.new(2022, 7, 26)
    (Date.compare(~D[2022-07-26], date3) == :eq) # |> IO.inspect # true


    # DIFFERENCE
    # Calculates the difference between two dates, in a full number of days.
    Date.diff(~D[2022-07-26], date2) # |> IO.inspect # -365


    # ADD
    # Adds the number of days to the given date.
    Date.add(~D[2022-07-26], 7) # |> IO.inspect # ~D[2022-08-02]
    Date.add(~D[2022-07-26], -7) # |> IO.inspect # ~D[2022-07-19]


    # beginning_of_month
    Date.beginning_of_month(~D[2022-07-26]) # |> IO.inspect # ~D[2022-07-01]
    # end_of_month
    Date.end_of_month(~D[2022-07-26]) # |> IO.inspect # ~D[2022-07-31]

    # beginning_of_week(date, starting_on \\ :default)
    Date.beginning_of_week(~D[2022-07-26]) # |> IO.inspect # ~D[2022-07-25]
    Date.beginning_of_week(~D[2022-07-26], :sunday) # |> IO.inspect # ~D[2022-07-24]
    # end_of_week(date, starting_on \\ :default)
    Date.end_of_week(~D[2022-07-26]) # |> IO.inspect # ~D[2022-07-31]
    Date.end_of_week(~D[2022-07-26], :sunday) # |> IO.inspect # ~D[2022-07-30]


    # TO
    Date.to_string(~D[2022-07-26]) # |> IO.inspect # "2022-07-26"
    Date.to_gregorian_days(~D[2022-07-26]) # |> IO.inspect # 738727
    Date.to_erl(~D[2022-07-26]) # |> IO.inspect # {2022, 7, 26}
    Date.to_iso8601(~D[2022-07-26], :extended) # |> IO.inspect # "2022-07-26"
    Date.to_iso8601(~D[2022-07-26], :basic) # |> IO.inspect # "20220726"


    # FROM
    # from_iso8601(string, calendar \\ Calendar.ISO)
    Date.from_iso8601("2022-07-26") # |> IO.inspect # {:ok, ~D[2022-07-26]}
    Date.from_iso8601("20220726") # |> IO.inspect # {:error, :invalid_format}
    # from_erl(tuple, calendar \\ Calendar.ISO)
    Date.from_erl({2022, 7, 26}) # |> IO.inspect # {:ok, ~D[2022-07-26]}
    Date.from_erl({2022, 7, 36}) # |> IO.inspect # {:error, :invalid_date}

    # OF
    Date.day_of_week(~D[2022-07-26]) # |> IO.inspect # 2
    Date.day_of_year(~D[2022-07-26]) # |> IO.inspect # 207
    Date.day_of_era(~D[2022-07-26]) # |> IO.inspect # {738362, 1}
    Date.quarter_of_year(~D[2022-07-26]) # |> IO.inspect # 3


    # days_in_month(Calendar.date()) :: Calendar.day()
    Date.days_in_month(~D[2022-07-26]) # |> IO.inspect # 31

    Date.leap_year?(~D[2022-07-26]) # |> IO.inspect # false

    Date.utc_today() #|> IO.inspect # ~D[2022-07-26]


    # RANGE
    month = Date.range(~D[2022-07-26], ~D[2022-08-26]) # |> IO.inspect # #DateRange<~D[2022-07-26], ~D[2022-08-26]>
    Enum.count(month) # |> IO.inspect # 32
    Enum.take(month, 3) # |> IO.inspect # [~D[2022-07-26], ~D[2022-07-27], ~D[2022-07-28]]
    Enum.take(month, -3) # |> IO.inspect # [~D[2022-08-24], ~D[2022-08-25], ~D[2022-08-26]]
    Enum.member?(month, ~D[2022-08-02]) # |> IO.inspect # true

    # is it within first week?
    Enum.member?(Enum.take(month, 7), ~D[2022-08-02]) # |> IO.inspect # false


    # TIME
    time = ~T[22:05:30.01]
    time.hour # |> IO.inspect # 22
    time.minute # |> IO.inspect # 5
    time.second # |> IO.inspect # 30
  end
end

MyDateTime.main()
