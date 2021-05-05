defmodule DiscordEmbedValidator.Guard do
  @moduledoc false

  defguard between(value, min, max) when value >= min and value <= max
end
