defmodule :my_comprehensions do
  # https://hexdocs.pm/elixir/Kernel.SpecialForms.html#for/1

  def a, do: for x <- [1,2,3], do: x*x

  @spec matrix :: list(any)
  def matrix do
    for x <- [1,2,3], y <- [4,5,6] do
    # [x, y, x * y]
    { x, y, x * y }
    end
  end

  @doc """
  matrix_to_map([1,2,3], [1,2,3])
  =>
  %{
  {1, 4} => 4,
  {1, 5} => 5,
  ...
  }
  """
  @spec matrix_to_map(list(integer), list(integer)) :: %{ { integer, integer } => integer }
  def matrix_to_map(x, y) do
    # for x <- [1,2,3], y <- [4,5,6], into: %{} do
    for x <- x, y <- y , into: %{} do
      { { x, y }, x * y }
    end
  end



  @doc """
  1. make [user, [liked jobs unique]]
  2. comprehend into [ { { user1, user2 }, similarity_score } ]
  """
  def user_similarity(reactions) do
    reactions
  end

  def unique_liked_jobs1(reactions) do
    # IMPORTANT - need to consume whole enumerable and assign to var before invoking reduce, cannot just pipe
    list = for [user_id | [ job_id | _ ]] <- reactions,
    uniq: true,
    do: [user_id, job_id]

    Enum.reduce(
      list,
      %{},
      fn [user_id, job_id], acc ->
        Map.update(acc, user_id, [job_id], & [job_id|&1])
      end
    )
    end

    @doc """
    Had to use MapSet because CompileError: cannot use :reduce alongside :into/:uniq in comprehension
    or could just Enum.uniq on acc keys?
    """
    def unique_liked_jobs(reactions) do
      for [user_id | [ job_id | _ ]] <- reactions,
      reduce: %{}
      do
        acc -> Map.update(
          acc,
          user_id,
          MapSet.new([job_id]),
          & MapSet.put(&1, job_id)
        )
      end
    end

    # def unique_liked_jobs(reactions) do
    #   rv = for [user_id | [ job_id | _ ]] <- reactions,
    #   reduce: %{}
    #   do
    #     acc -> Map.update(
    #       acc,
    #       user_id,
    #       [job_id],
    #       & [&1 | job_id]
    #     )
    #   end
    #   iterate_map(rv, fn v ->
    #     IO.inspect(v, label: 'v')
    #     Enum.uniq(v) end)
    # end

    # def iterate_map(map, fun) do
    #   Map.new(Enum.map(map, fn {k, v} ->
    #     # IO.inspect({k, v}, label: 'iterate_map')
    #     { k, fun.(v) }
    #   end))
    # end
end

# :my_comprehensions.a
# |> IO.inspect

# :my_comprehensions.matrix_to_map([1,2,3], [1,2,3])
# |> IO.inspect

reactions = [
  # ["user_id",n"job_id",n"direction", "time"]
  ["user_1", "3644", "true", "2019-08-13 09:13:39"],
  ["user_1", "7075", "true", "2019-08-13 09:13:39"],
  ["user_1", "7075", "true", "2019-08-13 09:13:39"], # duplicate
  ["user_1", "7075", "true", "2019-08-13 09:13:39"], # duplicate
  ["user_2", "7075", "true", "2019-08-22 07:53:40"],
  ["user_2", "7032", "true", "2019-08-22 07:53:40"],
  ["user_2", "9981", "true", "2019-08-22 07:53:40"],
  ["user_3", "7032", "true", "2019-08-28 17:43:15"],
  ["user_3", "9981", "true", "2019-08-28 18:32:47"],
  ["user_4", "7317", "true", "2019-08-25 20:14:18"],
  ["user_5", "1", "true", "2019-09-24 15:03:47"],
  ["user_5", "11237", "true", "2019-09-24 15:03:47"],
  ["user_6", "6122", "true", "2019-08-14 15:21:10"],
  ["user_7", "4566", "true", "2019-09-01 20:52:34"],
]

:my_comprehensions.unique_liked_jobs(reactions)
|> IO.inspect
