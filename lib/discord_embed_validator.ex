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
      :ok
  """

  def valid? (embed) do
    cond do
      is_struct(embed) ->
        embed
        |> Map.from_struct
        |> valid?
      is_map(embed) ->
        validate(embed)
    end
  end

  defp validate (embed) do
    Skooma.valid?(embed, valid_embed_schema())
  end

  defp valid_embed_schema do
    optional_url_value = [:string, :not_required, &Utils.is_url/1]

    # footer_schema = %{
    #   text: :string,
    #   # icon_url: optional_url_value,
    #   # proxy_icon_url: optional_url_value
    # }

    valid_embed_schema = %{
      title: [:string, :not_required, Validators.max_length(256)],
      description: [:string, :not_required, Validators.max_length(2048)],
      url: optional_url_value,
      timestamp: [:string, :not_required, &Utils.is_iso8601/1],
      color: [:number, :not_required, &Utils.is_color/1],
      # footer: [footer_schema, :not_required]
    }

    valid_embed_schema
  end
end
