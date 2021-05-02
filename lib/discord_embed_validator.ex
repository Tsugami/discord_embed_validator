defmodule DiscordEmbedValidator do
  alias Skooma.Validators
  alias DiscordEmbedValidator.Utils

  @moduledoc """
  Documentation for `DiscordEmbedValidator`.
  """

  @doc """
  Valid an Embed

  ## Examples

      iex> DiscordEmbedValidator.valid?(%{description: "my embed description", title: "my embed title"})
      %{description: "my embed description", title: "my embed title"}

      iex>{:error, _reason} = DiscordEmbedValidator.valid?(%{description: "my embed description", title: 11})

  """

  def valid? (embed) do
    if is_struct(embed) do
      do_valid?(Map.from_struct(embed))
    else
      do_valid?(embed)
    end
  end

  defp do_valid? (embed) do
    case Skooma.valid?(embed, valid_embed_schema()) do
      {:error, reason} -> {:error, reason}
      :ok -> embed
    end
  end

  defp valid_embed_schema do
    %{
      title: [:string, :not_required, Validators.max_length(256)],
      description: [:string, :not_required, Validators.max_length(2048)],
      url: [:string, :not_required, &(Utils.is_url(&1))],
      timestamp: [:string, :not_required, &(Utils.is_iso8601(&1))],
      color: [:number, :not_required, &(Utils.is_color(&1))]
    }
  end
end
