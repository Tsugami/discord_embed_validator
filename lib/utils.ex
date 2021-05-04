defmodule DiscordEmbedValidator.Utils do
  import DiscordEmbedValidator.Guard, only: [between: 3]
  @moduledoc false

  @doc """
    Check if a string is a URL.

    Returns `boolean`.

    Examples:
      iex> DiscordEmbedValidator.Utils.is_url("https://elixir-lang.org/docs.html")
      true

      iex> DiscordEmbedValidator.Utils.is_url("invalid_url")
      false
  """

  def is_url(str) when is_binary(str) do
    uri = URI.parse(str)
    case uri do
      %URI{scheme: nil} -> false
      %URI{host: nil} -> false
      %URI{path: nil} -> false
      _ -> true
    end
  end

  def is_url(_any), do: false
  @doc """
    Check is if timestamp is an ISO8601 Timestamp.

    Returns `boolean`.

    Examples:
      iex> DiscordEmbedValidator.Utils.is_iso8601("2015-01-23")
      true

      iex> DiscordEmbedValidator.Utils.is_iso8601("2015:01:23")
      false

      iex> DiscordEmbedValidator.Utils.is_iso8601("2015-01-32")
      false
  """

  def is_iso8601(timestamp) when is_binary(timestamp) do
    case Date.from_iso8601(timestamp) do
      {:ok, _date} -> true
      {:error, _reason} -> false
    end
  end

  def is_iso8601(_timestamp), do: false

  @doc """
    Check if color is valid

    Returns `boolean`.


     Examples:
      iex> DiscordEmbedValidator.Utils.is_color(3254)
      true

      iex> DiscordEmbedValidator.Utils.is_color("invalid_color")
      false
  """

  def is_color(color)
    when is_integer(color) and between(color, 0, 16_777_215),
    do: true

  def is_color(_color), do: false

  @doc """
   Get the length of an prop on Map

    Returns `number`.


     Examples:
      iex> DiscordEmbedValidator.Utils.fetch_value_length(%{bar: "foo"}, :bar)
      3

      iex> DiscordEmbedValidator.Utils.fetch_value_length(%{key: %{bar: "foo-bar"}}, [:key, :bar])
      7
  """

  def fetch_value_length(map, key) when is_atom(key) do
    case Map.get(map, key, '') do
      val when is_binary(val) -> String.length(val)
      _ -> 0
    end
  end

  def fetch_value_length(map, keys) when is_list(keys) do
    case get_in(map, keys) do
      val when is_binary(val) -> String.length(val)
      _ -> 0
    end
  end
end
