defmodule Input do
  defmacro path do
    quote do
      Path.join([File.cwd!(), "input", Path.basename(__ENV__.file, "_test.exs") <> ".txt"])
    end
  end

  @doc """
    Prints out a description and a content unless we are in CI
  """
  def show(desc, content) do
    unless System.get_env("GITHUB_ACTION") do
      IO.puts("\n#{desc}")
      IO.write(content)
    end

    content
  end
end
