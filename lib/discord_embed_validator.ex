defmodule DiscordEmbedValidator do
  # alias Skooma.Validators
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
    case Vex.validate(embed, valid_embed_schema()) do
      {:ok, _data} -> :ok
      {:error, reason} -> {:error, reason}
    end
  end

  defp valid_embed_schema do
    # footer_schema = %{
    #   text: :string,
    #   # icon_url: optional_url_value,
    #   # proxy_icon_url: optional_url_value
    # }

    # %{
    #   title: [:string, :not_required, Validators.max_length(256)],
    #   description: [:string, :not_required, Validators.max_length(2048)],
    #   url: optional_url_value,
    #   timestamp: [:string, :not_required, &(Utils.is_iso8601(&1))],
    #   color: [:number, :not_required, &(Utils.is_color(&1))],
    #   footer: [footer_schema, :not_required]
    # }

    [
      title: [length: [max: 256]],
      description: [length: [max: 2048]],
      url: [by: [function: &Utils.is_url/1, allow_nil: true]],
      timestamp: [by: [function: &Utils.is_iso8601/1, allow_nil: true]],
      color: [by: [function: &Utils.is_color/1, allow_nil: true]]
    ]
  end
end
