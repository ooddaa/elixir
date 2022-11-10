case File.read("yes") do
  {:ok, data} -> IO.inspect(data)
  {:error, reason} -> IO.inspect(reason)
end

case File.read("doesnt_exist") do
  {:ok, data} -> IO.inspect(data)
  {:error, :enoent} -> IO.puts("hehe no file")
  {:error, reason} -> IO.inspect(reason)
end

# chmod 000 no_access
case File.read("no_access") do
  {:ok, data} -> IO.inspect(data)
  {:error, :eacces} -> IO.puts("hehe no access")
  {:error, reason} -> IO.inspect(reason)
end
