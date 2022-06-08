# https://hexdocs.pm/elixir/Map.html

defmodule EmotionWheel do
  import IO
  import Enum
  @moduledoc """
  Contains the Wheel of Emotions
  https://d207ibygpg2z1x.cloudfront.net/image/upload/v1586561082/articles_upload/content/ejuktec3mb8wv51i9nlm.png
  """

  @wheel %{
    happy: %{
      playful: { :aroused, :cheeky },
      content: { :free, :joyful },
      interested: { :curious, :inquisitive },
      proud: { :successful, :confident },
      accepted: { :respected, :valued },
      powerful: { :courageous, :creative },
      peaceful: { :loving, :thankful },
      trusting: { :sensitive, :intimate },
      optimistic: { :hopeful, :inspired },
    }
  }
  @doc """
  Instantiates the Wheel
  """
  def print_wheel do

    puts join(Tuple.to_list(@wheel[:happy][:content]), ", ") # free, joyful

    puts elem(@wheel.happy.content, 0) # :free
    # puts IO.inspect(elem(@wheel.happy.content, 0)) # :free
    puts Map.fetch(@wheel, :happy) !== nil
    # puts Map.fetch(@wheel, :loving) # error

  end

  def wheel_keys do
    # puts Map.keys(@wheel)
    # puts Map.keys(%{ lol: 123, haha: true })
    # puts join(Map.keys(%{a: 1, b: 2}), ", ")
    # print(Map.keys(%{a: 1, b: 2}))
    print(%{a: 1, b: 2})
  end

  @doc """
  prints a list to stdout
  which is notoriously not as simple as in JS or Python
  but we aren't looking for easy way out, are we... are we?
  """
  @spec print(list) :: none
  def print(stuff) when is_list(stuff) do
    # I need to know the type of element in the list to stringify it correctly
    str = ""

    rv = reduce(stuff, str, fn val, acc ->
      cond do
        is_tuple(stuff) -> acc <> join(Tule.to_list(stuff), ", ")
        is_map(stuff) -> acc <> print(Map.to_list(stuff))
        true -> acc <> stuff
      end
      acc <> val
    end)

    puts rv
  end
  # def print(stuff) when is_map(stuff), do: puts join(Map.to_list(stuff), ", ")
  def print(stuff) when is_map(stuff), do: print(Map.to_list(stuff))
  # def print(stuff)

end

EmotionWheel.wheel_keys()


# cond do
#   age >= 14 -> IO.puts("You can wait")
#   age >= 16 -> IO.puts("You can drive")
#   age >= 18 -> IO.puts("You can vote")
#   true -> IO.puts("Default")
# end

# # Case works like switch
# case 2 do
#   1 -> IO.puts("Entered 1")
#   2 -> IO.puts("Entered 2")
#   _ -> IO.puts("Default")
# end
