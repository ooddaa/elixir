defmodule :matching_tuples do
  def tuples do
    person = { :person, :oda, 35 }
    { :person, name, age } = person
    # name |> IO.inspect
    # age |> IO.inspect

    { { year, month, day }, { _hour, minute, second } } = :calendar.local_time()
    [year, month, day] # |> IO.inspect
    [minute, second] # |> IO.inspect

    { amount, amount, amount } = { 1, 1, 1 }
    # { amount, amount, amount } = { 1, 1, 2 } # will throw (MatchError) no match of right hand side value: {1, 1, 2}

    # MATCH TO VARIABLE'S CONTENT
    expected_name = "Darth"
    # { :person, ^expected_name, age } = person # (MatchError) no match of right hand side value: {:person, :oda, 35}
    expected_name = :oda
    { :person, ^expected_name, age } = person # ok
  end

  def lists do
    [ 1,     second, third  ] = [1,2,3]
    [ first, second, third  ] = [1,2,3]
    [ _,     second, second ] = [1,2,2]
    [ _,     _,      third  ] = [1,2,3]


    [head | tail] = [1,2,3]
    [head | [second, _]] = [1,2,3]
    second # |> IO.inspect # 2
  end

  def maps do
    person = %{ name: "oda", age: 35, bjj_belt: :purple }
    %{ name: name, age: age } = person
    [name, age] # |> IO.inspect # ["oda", 35]
  end
end

# :matching_tuples.tuples
# :matching_tuples.lists
# :matching_tuples.maps
