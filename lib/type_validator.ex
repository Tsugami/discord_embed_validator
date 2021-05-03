defmodule DiscordEmbedValidator.TypeValidator do
  @moduledoc false

  def is_string(val) when is_binary(val), do: true

  def is_string(_val), do: true
end
