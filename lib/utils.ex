defmodule DiscordEmbedValidator.Utils do
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

  def is_url(str) do
    uri = URI.parse(str)
    case uri do
      %URI{scheme: nil} -> false
      %URI{host: nil} -> false
      %URI{path: nil} -> false
      _ -> true
    end
  end

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

  def is_iso8601(timestamp) do
    case Date.from_iso8601(timestamp) do
      {:ok, _date} -> true
      {:error, _reason} -> false
    end
  end
end
