defmodule DiscordEmbedValidator.Utils do
  @moduledoc false

  @doc """
    Check if a string is a URL

    Examples:
      iex> DiscordEmbedValidator.Utils.is_url("http://google.com/")
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
end
