defmodule DiscordEmbedValidator.Guard do
  @moduledoc """
    Custom Guard to valdate
  """

  defguard between(value, min, max) when value >= min and value <= max
end
