# https://hexdocs.pm/elixir/Kernel.SpecialForms.html#with/1

defmodule :user_form do
  def extract_username(%{username: username}), do: {:ok, username}
  def extract_username(_), do: {:error, "username missing"}

  def extract_password(%{password: password}), do: {:ok, password}
  def extract_password(_), do: {:error, "password missing"}

  def extract(map) do
    with {:ok, username} <- extract_username(map),
         {:ok, password} <- extract_password(map),
         timestamp = DateTime.utc_now() do
      %{username: username, password: password, timestamp: timestamp}
    end
  end

  @doc """
    The else block works like a case clause: it can have multiple clauses, and the first match will be used.
    """
  def extract!(map) do

    with {:ok, username} <- extract_username(map),
         {:ok, password} <- extract_password(map),
         timestamp = DateTime.utc_now() do
      %{username: username, password: password, timestamp: timestamp}
    else
      # Variables bound inside with (such as width in this example) are not available in the else block.
      # what useful stuff can I do here? except somehow modify the error message
      :error -> {:error, "something wrong"}
      _ -> {:error, "hz"}
    end
  end
end

# :user_form.extract(%{}) |> IO.inspect(label: 'empty')
# :user_form.extract(%{username: "oda", password: "moon"}) |> IO.inspect(label: 'ok')

# :user_form.extract!(%{}) |> IO.inspect(label: 'empty') # hz
# :user_form.extract!(%{error: :error}) |> IO.inspect(label: 'error') # hz

# :user_form.extract!(%{username: "oda" }) |> IO.inspect(label: 'password not ok')
# :user_form.extract!(%{username: "oda", password: "moon"}) |> IO.inspect(label: 'ok')
