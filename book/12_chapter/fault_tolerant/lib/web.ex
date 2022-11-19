defmodule Todo.Web do
  use Plug.Router

  plug :match
  plug :dispatch

  post "/add_entry" do
    conn = Plug.Conn.fetch_query_params(conn)
    list_name = Map.fetch!(conn.params, "list")
    title = Map.fetch!(conn.params, "title")
    date = Date.from_iso8601!(Map.fetch!(conn.params, "date"))

    list_name
    |> String.to_atom()
    |> Todo.Cache.server_process()
    |> Todo.Server.add_entry(%{ title: title, date: date })

    conn
    |> Plug.Conn.put_resp_content_type("text/plain")
    |> Plug.Conn.send_resp(200, "OK")
  end

  get "/entries" do
    conn = Plug.Conn.fetch_query_params(conn)
    list_name = Map.fetch!(conn.params, "list")
    date = Date.from_iso8601!(Map.fetch!(conn.params, "date"))

    resp =
      list_name
      |> String.to_atom()
      |> Todo.Cache.server_process()
      |> Todo.Server.entries(date)
      |> IO.inspect(label: "response") # [%{date: ~D[2022-11-16], id: 1, title: "Yo"}]

    conn
    |> Plug.Conn.put_resp_content_type("text/plain")
    |> Plug.Conn.send_resp(
      200,
      resp |> Enum.map(&("#{&1.date} #{&1.title}")) |> Enum.join("\n")
      )
  end

  def child_spec(_) do
    Plug.Adapters.Cowboy.child_spec(
      scheme: :http,
      options: [port: Application.fetch_env!(:todo, :http_port)],
      plug: __MODULE__,
    )
  end
end
